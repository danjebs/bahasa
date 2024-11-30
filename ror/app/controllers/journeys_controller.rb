class JourneysController < ApplicationController
  def create
    language = Language.find(journey_params[:language_id])

    course = Course.create!(
      language: language,
      creator: current_user,
      name: "#{current_user.name} learns #{language.name}"
    )

    @journey = Journey.new(user: current_user, course: course)

    authorize @journey

    respond_to do |format|
      if @journey.save
        format.html { redirect_to @journey.course, notice: "Journey was successfully created." }
        format.json { render json: @journey, status: :created, location: @journey }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @journey.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def journey_params
      # params.require(:journey).permit(:id, :language_id)
      params.permit(:language_id)
    end
end
