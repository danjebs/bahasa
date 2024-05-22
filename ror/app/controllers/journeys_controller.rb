class JourneysController < ApplicationController
  before_action :set_journey, only: [:show]

  def index
    authorize Journey

    languages_to_learn = Language.where.not(id: current_user.languages.pluck(:id))

    render Journeys::JourneyListing.new(
      journeys: current_user.journeys,
      languages_to_learn: languages_to_learn
    )
  end

  def show
    authorize @journey

    render Journeys::JourneyShow.new(journey: @journey)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journey
      redirect_to :root if params[:lang].nil?

      # TODO: don't call this on preload
      language = Language.find_by(code: params[:lang])
      @journey = current_user.journeys.find_or_create_by(language_id: language.id)
    end

    # Only allow a list of trusted parameters through.
    def journey_params
      params.require(:journey).permit(:id, :user_id, :language_id)
    end
end