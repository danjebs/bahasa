class TranslationCardsController < ApplicationController
  before_action :set_exercise, only: [:edit, :update]

  def new
    @translation_card = TranslationCard.new(lesson_id: params[:lesson_id])

    authorize @translation_card

    render Cards::Translations::TranslationCardNew.new(lesson_id: @translation_card.lesson_id)
  end

  def create
    @translation_card = TranslationCard.new(translation_card_params)

    authorize @translation_card

    respond_to do |format|
      if @translation_card.save
        format.turbo_stream
        format.html {
          redirect_to(lesson_url(@translation_card.lesson), notice: "Translation Card was successfully created.")
        }
        format.json { render json: @translation_card, status: :created, location: @translation_card }
      else
        format.html {
          render Cards::Translations::TranslationCardNew.new(lesson_id: @translation_card.lesson_id),
          status: :unprocessable_entity
        }
        format.json { render json: @translation_card.errors, status: :unprocessable_entity }
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
        format.json { render json: @translation_card, status: :created, location: @translation_card }
      else
        format.html {
          render Cards::Translations::TranslationCardEdit.new(translation_card: @translation_card),
          status: :unprocessable_entity
        }
        format.json { render json: @translation_card.errors, status: :unprocessable_entity }
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
