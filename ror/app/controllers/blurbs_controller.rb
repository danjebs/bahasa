class BlurbsController < ApplicationController
  before_action :set_blurb, only: [:edit, :update]

  def new
    authorize Blurb

    @blurb = Blurb.new(lesson_id: params[:lesson_id])

    render Exercises::Blurbs::BlurbNew.new(blurb: @blurb)
  end

  def create
    authorize Blurb

    @blurb = Blurb.new(blurb_params)

    respond_to do |format|
      if @blurb.save
        format.html { redirect_to @blurb.lesson, notice: "Exercise was successfully created." }
        format.json { render json: @blurb, status: :created, location: @blurb }
      else
        format.html {
          render Exercises::Blurbs::BlurbNew.new(blurb: @blurb),
          status: :unprocessable_entity
        }
        format.json { render json: @blurb.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @blurb

    render Exercises::Blurbs::BlurbEdit.new(blurb: @blurb)
  end

  def update
    authorize @blurb

    respond_to do |format|
      if @blurb.update(blurb_params)
        format.turbo_stream
        format.html {
          render Exercises::Blurbs::BlurbDetails.new(blurb: @blurb),
          notice: "Blurb was successfully updated."
        }
        format.json { render json: @blurb, status: :created, location: @blurb }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blurb.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blurb
      @blurb = Blurb.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blurb_params
      params.require(:blurb).permit(:lesson_id, :title, :position, :content)
    end
end
