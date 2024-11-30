class PhraseListsController < ApplicationController
  before_action :set_phrase_list, only: [:edit, :update]

  def new
    @phrase_list = PhraseList.new(word_list_params)

    authorize @phrase_list

    render Exercises::PhraseLists::PhraseListNew.new(phrase_list: @phrase_list)
  end

  def create
    @phrase_list = PhraseList.new(phrase_list_params)

    authorize @phrase_list

    respond_to do |format|
      if @phrase_list.save
        format.html { redirect_to @phrase_list.lesson, notice: "Phrase List was successfully created." }
        format.json { render json: @phrase_list, status: :created, location: @phrase_list }
      else
        format.html {
          redirect_to @phrase_list.lesson,
          status: :unprocessable_entity
        }
        format.json { render json: @phrase_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @phrase_list

    render Exercises::PhraseLists::PhraseListEdit.new(phrase_list: @phrase_list)
  end

  def update
    authorize @phrase_list

    respond_to do |format|
      if @phrase_list.update(phrase_list_params)
        format.html {
          redirect_to @phrase_list.lesson,
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
      params.require(:phrase_list).permit(:lesson_id, :title, :position)
    end
end
