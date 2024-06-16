class DecksController < ApplicationController
  before_action :set_deck, only: [:show]
  before_action :set_breadcrumbs

  def index
    authorize Deck

    render Decks::DeckList.new(decks: current_user.decks)
  end

  def show
    authorize @deck

    add_breadcrumb("Daily Practice")
  end

  def new
    authorize Deck

    @journey = current_user.journeys.joins(:language).find_by(language: { code: params[:lang] })
    @deck = Deck.new(journey_id: @journey.id)

    add_breadcrumb("New Practice")

    render Decks::DeckNew.new(deck: @deck)
  end

  def create
    authorize Deck

    @deck = DeckGenerator.call(
      journey_id: deck_params[:journey_id],
      difficulty: deck_params[:difficulty],
      duration: deck_params[:duration],
    )

    respond_to do |format|
      if @deck.save
        format.html { redirect_to @deck, notice: "Deck was successfully created." }
        format.json { render json: @deck, status: :created, location: @deck }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      @deck = Deck.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def deck_params
      params.require(:deck).permit(:id, :journey_id, :difficulty, :duration)
    end

    def set_breadcrumbs
      language = Language.find_by(code: params[:lang])
      add_breadcrumb(language.name, language.base_path) if language.present?
    end
end
