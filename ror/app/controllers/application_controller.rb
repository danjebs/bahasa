class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_lang
  protect_from_forgery with: :exception

  unless Rails.application.config.consider_all_requests_local
    after_action :verify_authorized, except: :index, unless: :devise_controller?
    # after_action :verify_policy_scoped, only: :index

    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def set_lang
      @lang = params[:lang]
    end

    def default_url_options
      { lang: @lang }
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    def render_404
      respond_to do |format|
        format.html { render template: "errors/not_found", status: 404 }
        format.all { render nothing: true, status: 404 }
      end
    end
end
