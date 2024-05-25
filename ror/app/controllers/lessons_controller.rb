class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    authorize Lesson

    @lessons = Lesson.all

    render Lessons::LessonList.new(lessons: @lessons)
  end

  def show
    authorize @lesson
  end

  def new
    authorize Lesson

    @lesson = Lesson.new

    render Lessons::LessonNew.new(lesson: @lesson)
  end

  def edit
    authorize @lesson

    render Lessons::LessonEdit.new(lesson: @lesson)
  end

  def create
    authorize Lesson

    @lesson = Lesson.new(**lesson_params, language: Language.find_by(code: params[:lang]))

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully created." }
        format.json { render json: @lesson, status: :created, location: @lesson }
      else
        format.html {
          render Lessons::LessonNew.new(lesson: @lesson),
          status: :unprocessable_entity
        }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
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
        format.html {
          render Lessons::LessonEdit.new(lesson: @lesson),
          status: :unprocessable_entity
        }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])

    # TODO: don't call this on preload
    # TODO add logic to hadle case when the journey/step does not exist
    @step = current_user
      .journeys.find_by(language_id: @lesson.language_id)
      .steps.create_with(status: :started).find_or_create_by!(lesson_id: @lesson.id)
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:title, :position)
    end
end
