class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update]
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

    respond_to do |format|
      if @lesson.update(lesson_params)
        format.turbo_stream
        format.html {
          render Lessons::LessonShow.new(lesson: @lesson),
          notice: "Lesson was successfully updated."
        }
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
      format.turbo_stream
      format.html {
        redirect_to lessons_url,
        notice: "Lesson was successfully destroyed."
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:title)
    end
end
