class WordListsController < ApplicationController
  before_action :set_word_list, only: [:edit, :update]

  def new
    authorize WordList

    @word_list = WordList.new(word_list_params)

    render Exercises::WordLists::WordListNew.new(word_list: @word_list)
  end

  def create
    authorize WordList

    @word_list = WordList.new(word_list_params)

    respond_to do |format|
      if @word_list.save
        format.html { redirect_to @word_list.lesson, notice: "Word List was successfully created." }
        format.json { render json: @word_list, status: :created, location: @word_list }
      else
        format.html {
          redirect_to @word_list.lesson,
          status: :unprocessable_entity
        }
        format.json { render json: @word_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @word_list

    render Exercises::WordLists::WordListEdit.new(word_list: @word_list)
  end

  def update
    authorize @word_list

    respond_to do |format|
      if @word_list.update(word_list_params)
        format.html { redirect_to @word_list.lesson, notice: "Word List was successfully updated." }
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
      params.require(:word_list).permit(:lesson_id, :title, :type, :position)
    end
end
