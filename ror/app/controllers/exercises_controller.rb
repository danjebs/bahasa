class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:destroy]

  def index
    authorize Exercise

    @exercises = Exercise.all
  end

  # def show
  #   authorize @exercise
  # end

  def new
    authorize Exercise

    @exercise = Exercise.new
  end

  # def edit
  #   authorize @exercise
  # end

  def create
    authorize Exercise

    @exercise = Exercise.new(exercise_params)

    respond_to do |format|
      if @exercise.save
        format.turbo_stream do
          turbo_stream.append(:exercises, partial: "exercises/exercise", locals: { exercise: @exercise })
        end
        format.html { redirect_to exercise_url(@exercise), notice: "Exercise was successfully created." }
        format.json { render :show, status: :created, location: @exercise }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   authorize @exercise

  #   respond_to do |format|
  #     if @exercise.update(exercise_params)
  #       format.html { redirect_to exercise_url(@exercise), notice: "Exercise was successfully updated." }
  #       format.json { render :show, status: :ok, location: @exercise }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @exercise.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /exercises/1 or /exercises/1.json
  def destroy
    @exercise.destroy!

    respond_to do |format|
      format.html { redirect_to exercises_url, notice: "Exercise was successfully destroyed." }
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
      params.require(:exercise).permit(:lesson_id, :title, :type, :position)
    end
end
