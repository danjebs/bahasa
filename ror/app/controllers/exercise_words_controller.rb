class ExerciseWordsController < ApplicationController
  before_action :set_exercise_word, only: %i[ show edit update destroy ]

  def index
    authorize ExerciseWord

    @exercise_words = ExerciseWord.all
  end

  def show
    authorize @exercise_word
  end

  def new
    authorize ExerciseWord

    @exercise_word = ExerciseWord.new(exercise_id: params[:exercise_id])
  end

  def edit
    authorize @exercise_word
  end

  def create
    authorize ExerciseWord

    @exercise_word = ExerciseWord.new(exercise_word_params)

    respond_to do |format|
      if @exercise_word.save
        format.turbo_stream do
          turbo_stream.append(:exercise_words,
            partial: "exercise_words/exercise_word",
            locals: { exercise_word: @exercise_word }
          )
        end
        format.html { redirect_to exercise_word_url(@exercise_word), notice: "Exercise word was successfully created." }
        format.json { render :show, status: :created, location: @exercise_word }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exercise_word.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @exercise_word

    respond_to do |format|
      if @exercise_word.update(exercise_word_params)
        format.html { redirect_to exercise_word_url(@exercise_word), notice: "Exercise word was successfully updated." }
        format.json { render :show, status: :ok, location: @exercise_word }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exercise_word.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @exercise_word

    @exercise_word.destroy!

    respond_to do |format|
      format.turbo_stream { turbo_stream.remove(:exercise_words) }
      format.html { redirect_to exercise_words_url, notice: "Exercise word was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_word
      @exercise_word = ExerciseWord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exercise_word_params
      params.require(:exercise_word).permit(:exercise_id, :word, :translation, :position)
    end
end
