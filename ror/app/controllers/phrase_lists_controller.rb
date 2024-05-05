class PhraseListsController < ApplicationController
  before_action :set_phrase_list, only: [:edit, :update]

  def edit
    authorize @phrase_list
  end

  def update
    authorize @phrase_list

    respond_to do |format|
      if @phrase_list.update(phrase_list_params)
        format.html {
          redirect_to lesson_url(@phrase_list.lesson),
          notice: "Phrase List was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phrase_list
      @phrase_list = PhraseList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def phrase_list_params
      params.require(:phrase_list).permit(:title, :position)
    end
end
