class CardsController < ApplicationController
  before_action :set_card, only: [:update, :destroy]

  def new
    @card = Card.new(lesson_id: params[:lesson_id])

    authorize @card

    render Cards::CardNew.new(card: @card)
  end

  def create
    @card = Card.new(card_params)

    authorize @card

    respond_to do |format|
      if @card.save
        format.turbo_stream
        format.html {
          redirect_to(lesson_url(@card.lesson), notice: "Card was successfully created.")
        }
        format.json { render json: @card, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @card

    if card_params[:position].present? && card_params[:position] != @card.position
      @card.insert_at(card_params[:position])
    end

    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to card_url(@card), notice: "Card was successfully updated." }
        format.json { render json: @card, status: :created, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @card

    @card.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to lesson_url(@card.lesson), notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:id, :type, :front, :back, :lesson_id, :position)
    end
end
