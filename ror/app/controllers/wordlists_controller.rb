class WordlistsController < ApplicationController
  before_action :set_wordlist, only: %i[ show edit update destroy ]

  # GET /wordlists or /wordlists.json
  def index
    authorize Wordlist

    @wordlists = Wordlist.all
  end

  # GET /wordlists/1 or /wordlists/1.json
  def show
    authorize @wordlist
  end

  # GET /wordlists/new
  def new
    @wordlist = Wordlist.new
  end

  # GET /wordlists/1/edit
  def edit
    authorize @wordlist
  end

  # POST /wordlists or /wordlists.json
  def create
    @wordlist = Wordlist.new(wordlist_params)
    @wordlist.language = Language.find_by(code: params[:lang])

    respond_to do |format|
      if @wordlist.save
        format.html { redirect_to wordlist_url(@wordlist), notice: "Wordlist was successfully created." }
        format.json { render :show, status: :created, location: @wordlist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wordlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wordlists/1 or /wordlists/1.json
  def update
    authorize @wordlist

    respond_to do |format|
      if @wordlist.update(wordlist_params)
        format.html { redirect_to wordlist_url(@wordlist), notice: "Wordlist was successfully updated." }
        format.json { render :show, status: :ok, location: @wordlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wordlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wordlists/1 or /wordlists/1.json
  def destroy
    @wordlist.destroy!

    respond_to do |format|
      format.html { redirect_to wordlists_url, notice: "Wordlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wordlist
      @wordlist = Wordlist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wordlist_params
      params.require(:wordlist).permit(:name, :slug)
    end
end
