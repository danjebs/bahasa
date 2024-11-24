class LessonsController < ApplicationController
  before_action :set_course, only: [:index, :new, :create]
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_breadcrumbs

  def index
    authorize Lesson

    @lessons = policy_scope(Lesson.all)
  end

  def show
    authorize @lesson

    add_breadcrumb(@lesson.title, @lesson)
  end

  def new
    @lesson = Lesson.new(course_id: @course.id)

    authorize @lesson

    add_breadcrumb("New Lesson")
  end

  def create
    @lesson = Lesson.new(**lesson_params)

    authorize @lesson

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully created." }
        format.json { render json: @lesson, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @lesson

    add_breadcrumb("Edit #{@lesson.title}")
  end

  def update
    authorize @lesson

    if lesson_params[:position].present? && lesson_params[:position] != @lesson.position
      @lesson.insert_at(lesson_params[:position])
    end

    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: "Lesson was successfully updated." }
        format.json { render json: @lesson, status: :created, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @lesson

    @lesson.destroy!

    respond_to do |format|
      format.html { redirect_to lessons_url, notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:title, :position, :course_id)
    end

    def set_breadcrumbs
      if @lesson.present?
        add_breadcrumb(@lesson.course.language.name, @lesson.course)
      elsif @course.present?
        add_breadcrumb(@course.language.name, @course)
        add_breadcrumb("Lessons", course_lessons_path(@course))
      end
    end
end
