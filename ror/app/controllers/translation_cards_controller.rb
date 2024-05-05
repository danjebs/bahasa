class TranslationCardsController < ApplicationController
  before_action :set_exercise, only: [:edit, :update]

  def new
    authorize TranslationCard

    @translation_card = TranslationCard.new(lesson_id: params[:lesson_id])

    render Cards::Translations::TranslationCardNew.new(translation_card: @translation_card)
  end

  def create
    authorize TranslationCard

    @translation_card = TranslationCard.new(translation_card_params)

    respond_to do |format|
      if @translation_card.save
        format.turbo_stream
        format.html {
          redirect_to(lesson_url(@translation_card.lesson), notice: "Translation Card was successfully created.")
        }
      else
        format.html {
          render Cards::Translations::TranslationCardNew.new(translation_card: @translation_card),
          status: :unprocessable_entity
        }
      end
    end
  end

  def edit
    authorize @translation_card

    render Cards::Translations::TranslationCardEdit.new(translation_card: @translation_card)
  end

  def update
    authorize @translation_card

    respond_to do |format|
      if @translation_card.update(translation_card_params)
        format.html {
          render Cards::CardListing.new(card: @translation_card),
          notice: "Translation Card was successfully updated."
        }
      else
        format.html {
          render Cards::Translations::TranslationCardEdit.new(translation_card: @translation_card),
          status: :unprocessable_entity
        }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @translation_card = TranslationCard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def translation_card_params
      params.require(:translation_card).permit(:id, :type, :front, :back, :lesson_id, :position)
    end
end
