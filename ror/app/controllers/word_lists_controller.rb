class WordListsController < ApplicationController
  before_action :set_word_list, only: [:edit, :update]

  def edit
    authorize @word_list
  end

  def update
    authorize @word_list

    respond_to do |format|
      if @word_list.update(word_list_params)
        format.html {
          render Exercises::WordLists::WordListDetails.new(word_list: @word_list),
          notice: "Word List was successfully updated."
        }
        format.json { render json: @word_list, status: :created, location: @word_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @word_list.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word_list
      @word_list = WordList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def word_list_params
      params.require(:word_list).permit(:title, :position)
    end
end
