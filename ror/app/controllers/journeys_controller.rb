class JourneysController < ApplicationController
  before_action :set_journey, only: [:show]
  before_action :set_breadcrumbs

  def index
    authorize Journey

    @languages_to_learn = Language.where.not(id: current_user.languages.pluck(:id) << 1)
  end

  def show
    authorize @journey
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

    def set_breadcrumbs
      language = Language.find_by(code: params[:lang])
      add_breadcrumb(language.name, language.base_path) if language.present?
    end
end
