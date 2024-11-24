class CoursesController < ApplicationController
  before_action :set_course, only: [:show]
  before_action :set_breadcrumbs

  def index
    authorize Course

    @courses = policy_scope(current_user.courses)
    @languages_to_learn = Language.where.not(id: current_user.languages.pluck(:id) << 1)
  end

  def show
    authorize @course

    @journey = current_user.journeys.find_by(course_id: @course.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find_by(params[:course_id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:id, :creator_id, :language_id)
    end

    def set_breadcrumbs
      add_breadcrumb("Courses", courses_path)
      add_breadcrumb(@course.language.name, course_path(@course)) if @course.present?
    end
end
