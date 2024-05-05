class PhrasesController < ApplicationController
  before_action :set_phrase, only: [:edit, :update, :destroy]

  def new
    authorize Phrase

    @phrase = Phrase.new(exercise_id: params[:exercise_id])

    render Phrases::PhraseNew.new(phrase: @phrase)
  end

  def edit
    authorize @phrase

    render Phrases::PhraseEdit.new(phrase: @phrase)
  end

  def create
    authorize Phrase

    @phrase = Phrase.new(phrase_params)

    respond_to do |format|
      if @phrase.save
        format.turbo_stream
        format.html {
          render Lessons::LessonShow.new(lesson: @phrase.exercise.lesson),
          notice: "Phrase was successfully created."
        }
      else
        format.html {
          render(
            Phrases::PhraseNew.new(phrase: @phrase),
            status: :unprocessable_entity
          )
        }
      end
    end
  end

  def update
    authorize @phrase

    if phrase_params[:position].present? && phrase_params[:position] != @phrase.position
      @phrase.insert_at(phrase_params[:position])
    end

    respond_to do |format|
      if @phrase.update(phrase_params)
        format.html {
          render Phrases::PhraseListing.new(phrase: @phrase),
          notice: "Phrase was successfully updated."
        }
      else
        format.html {
          render Phrases::PhraseEdit.new(phrase: @phrase),
          status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    authorize @phrase

    @phrase.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html {
        render Lessons::LessonShow(lesson: @phrase.exercise.lesson),
        notice: "Exercise phrase was successfully destroyed."
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phrase
      @phrase = Phrase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def phrase_params
      params.require(:phrase).permit(:exercise_id, :phrase, :translation, :position)
    end
end
