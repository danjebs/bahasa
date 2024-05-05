class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:update, :destroy]

  def new
    authorize Exercise

    @exercise = Exercise.new(lesson_id: params[:lesson_id])

    render Exercises::ExerciseNew.new(exercise: @exercise)
  end

  def create
    authorize Exercise

    @exercise = Exercise.new(exercise_params)

    respond_to do |format|
      if @exercise.save
        format.turbo_stream
        format.html {
          render Lessons::LessonShow.new(lesson: @exercise.lesson),
          notice: "Exercise was successfully created."
        }
        format.json { render json: @exercise, status: :created, location: @exercise }
      else
        format.html {
          render Exercises::ExerciseNew.new(exercise: @exercise),
          status: :unprocessable_entity
        }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @exercise

    if exercise_params[:position].present? && exercise_params[:position] != @exercise.position
      @exercise.insert_at(exercise_params[:position])
    end

    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html {
          render Lessons::LessonShow.new(lesson: @exercise.lesson),
          notice: "Exercise was successfully updated."
        }
        format.json { render json: @exercise, status: :created, location: @exercise }
      else
        format.html {
          render Exercises::ExerciseEdit.new(exercise: @exercise),
          status: :unprocessable_entity
        }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @exercise.destroy!

    respond_to do |format|
      format.html {
        render Lessons::LessonShow(lesson: @exercise.lesson),
        notice: "Exercise was successfully destroyed."
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @exercise = Exercise.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exercise_params
      params.require(:exercise).permit(:id, :lesson_id, :title, :type, :position)
    end
end
