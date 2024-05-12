class StaticPagesController < ApplicationController
  skip_after_action :verify_authorized

  def home
    if current_user&.default_language.present?
      redirect_to current_user.default_language
    elsif current_user.present?
      redirect_to journeys_path
    end

    redirect_to :new_user_session
  end
end