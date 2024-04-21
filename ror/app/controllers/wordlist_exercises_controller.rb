class WordlistExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]

  def index
    authorize WordlistExercise

    @exercises = WordlistExercise.all
  end

  def show
    authorize @wordlist_exercise
  end

  # def new
  #   authorize WordlistExercise

  #   @wordlist_exercise = WordlistExercise.new
  # end

  def edit
    authorize @wordlist_exercise
  end

  def create
    authorize WordlistExercise

    @wordlist_exercise = WordlistExercise.new(wordlist_exercise_params)

    respond_to do |format|
      if @wordlist_exercise.save
        format.turbo_stream { render turbo_stream: turbo_stream }
        format.html { redirect_to exercise_url(@wordlist_exercise), notice: "Wordlist Exercise was successfully created." }
        format.json { render :show, status: :created, location: @wordlist_exercise }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wordlist_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @wordlist_exercise

    respond_to do |format|
      if @wordlist_exercise.update(wordlist_exercise_params)
        format.html { redirect_to exercise_url(@wordlist_exercise), notice: "Wordlist Exercise was successfully updated." }
        format.json { render :show, status: :ok, location: @wordlist_exercise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wordlist_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @wordlist_exercise.destroy!

    respond_to do |format|
      format.html { redirect_to exercises_url, notice: "Wordlist Exercise was successfully destroyed." }
      format.json { head :no_content }
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
