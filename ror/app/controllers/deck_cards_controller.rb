class DeckCardsController < ApplicationController
  before_action :set_deck_card, only: [:update]

  def update
    authorize @deck_card

    respond_to do |format|
      if @deck_card.update(deck_card_params)
        DeckCardScorer.call(deck_card: @deck_card)

        format.html { redirect_to @deck_card, notice: "Deck Card was successfully created." }
        format.json { render json: @deck_card, status: :ok, location: @deck_card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deck_card.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deck_card
      @deck_card = DeckCard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def deck_card_params
      params.require(:deck_card).permit(:id, :status, :outcome, :time_taken)
    end
end
