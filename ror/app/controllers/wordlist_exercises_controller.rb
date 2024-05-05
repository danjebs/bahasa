class WordlistExercisesController < ApplicationController
  before_action :set_exercise, only: [:edit, :update]

  def edit
    authorize @wordlist_exercise
  end

  def update
    authorize @wordlist_exercise

    respond_to do |format|
      if @wordlist_exercise.update(wordlist_exercise_params)
        format.html {
          redirect_to lesson_url(@wordlist_exercise.lesson),
          notice: "Wordlist Exercise was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @wordlist_exercise = WordlistExercise.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wordlist_exercise_params
      params.require(:wordlist_exercise).permit(:title, :type, :position)
    end
end
