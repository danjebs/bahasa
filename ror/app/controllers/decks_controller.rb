class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :update]
  before_action :set_breadcrumbs, except: [:show]

  def index
    authorize Deck

    @decks = policy_scope(current_user.decks)

    render Decks::DeckList.new(decks: current_user.decks)
  end

  def show
    authorize @deck
  end

  def new

    @journey = current_user.journeys.joins(course: :language).find_by(course: { languages: { code: params[:lang] } })
    @deck = Deck.new(journey_id: @journey.id)

    authorize @deck

    add_breadcrumb("New Practice")

    render Decks::DeckNew.new(deck: @deck)
  end

  def create
    @deck = Deck.create!(
      journey_id: deck_params[:journey_id],
      step_id: deck_params[:step_id],
      status: :created,
      difficulty: deck_params[:difficulty],
    )

    authorize @deck

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

  def update
    authorize @deck

    respond_to do |format|
      if @deck.update(deck_params)
        @deck.prune_deck_cards if @deck.status_is_completed?

        format.html { redirect_to @deck, notice: "Deck Card was successfully updated." }
        format.json { render json: @deck, status: :ok, location: @deck }
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
      params.require(:deck).permit(:id, :journey_id, :step_id, :status, :difficulty)
    end

    def set_breadcrumbs
      language = Language.find_by(code: params[:lang])
      add_breadcrumb(language.name, language.base_path) if language.present?
    end
end
