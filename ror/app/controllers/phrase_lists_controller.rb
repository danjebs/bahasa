class PhraseListsController < ApplicationController
  before_action :set_phrase_list, only: [:edit, :update]

  def edit
    authorize @phrase_list

    render Exercises::PhraseLists::PhraseListEdit.new(phrase_list: @phrase_list)
  end

  def update
    authorize @phrase_list

    respond_to do |format|
      if @phrase_list.update(phrase_list_params)
        format.html {
          render Exercises::PhraseLists::PhraseListDetails.new(phrase_list: @phrase_list),
          notice: "Phrase List was successfully updated."
        }
        format.json { render json: @phrase_list, status: :created, location: @phrase_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @phrase_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
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
