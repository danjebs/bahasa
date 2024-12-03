class StaticPagesController < ApplicationController
  def home
    authorize :static_pages, :home?

    if current_user&.courses.last.present?
      redirect_to current_user.courses.last
    elsif current_user.present?
      redirect_to courses_path
    else
      redirect_to :new_user_session
    end
  end
end