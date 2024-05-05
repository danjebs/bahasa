class WordsController < ApplicationController
  before_action :set_word, only: [:edit, :update, :destroy]

  def new
    authorize Word

    @word = Word.new(exercise_id: params[:exercise_id])

    render Words::WordNew.new(word: @word)
  end

  def edit
    authorize @word

    render Words::WordEdit.new(word: @word)
  end

  def create
    authorize Word

    @word = Word.new(word_params)

    respond_to do |format|
      if @word.save
        format.turbo_stream
        format.html {
          render Lessons::LessonShow.new(lesson: @word.exercise.lesson),
          notice: "Word was successfully created."
        }
      else
        format.html {
          render(
            Words::WordNew.new(word: @word),
            status: :unprocessable_entity
          )
        }
      end
    end
  end

  def update
    authorize @word

    if word_params[:position].present? && word_params[:position] != @word.position
      @word.insert_at(word_params[:position])
    end

    respond_to do |format|
      if @word.update(word_params)
        format.html {
          render Words::WordListing.new(word: @word),
          notice: "Word was successfully updated."
        }
      else
        format.html {
          render Words::WordEdit.new(word: @word),
          status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    authorize @word

    @word.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html {
        render Lessons::LessonShow(lesson: @word.exercise.lesson),
        notice: "Exercise word was successfully destroyed."
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def word_params
      params.require(:word).permit(:exercise_id, :word, :translation, :position)
    end
end
