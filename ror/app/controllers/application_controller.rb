class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_lang
  protect_from_forgery with: :exception

  after_action :verify_authorized, unless: :devise_controller?
  # after_action :verify_policy_scoped, only: :index

  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, with: :render_404
    # rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :breadcrumbs

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def add_breadcrumb(name, path = nil)
    breadcrumbs << Breadcrumb.new(name, path)
  end

  private
    def set_lang
      @lang = params[:lang] if Language.exists?(code: params[:lang])
    end

    def default_url_options
      { lang: @lang }
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end

    def after_sign_in_path_for(resource)
      stored_location_for(resource) || super
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."

      if current_user.present?
        respond_to do |format|
          format.html { render file: Rails.root.join("public", "403.html"), status: :forbidden, layout: false }
          format.json { render json: { error: "Forbidden" }, status: :forbidden }
        end
      else
        store_user_location!
        redirect_to new_user_session_path
      end
    end

    def render_404
      respond_to do |format|
        format.html { render template: "errors/not_found", status: 404 }
        format.all { render nothing: true, status: 404 }
      end
    end
end
