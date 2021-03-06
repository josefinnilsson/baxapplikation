class PingpongsController < ApplicationController
  before_action :set_pingpong, only: [:show, :edit, :update, :destroy]

  # GET /pingpongs
  # GET /pingpongs.json
  def index
    @pingpong = Pingpong.new
    @pingpongs = Pingpong.all
    @toplist = User.all.sort_by(&:pingpong_score).reverse
  end

  # GET /pingpongs/1
  # GET /pingpongs/1.json
  def show
  end

  # GET /pingpongs/new
  def new
    @pingpong = Pingpong.new
  end

  # GET /pingpongs/1/edit
  def edit
  end

  # POST /pingpongs
  # POST /pingpongs.json
  def create
    @pingpong = Pingpong.new(pingpong_params)
      if @pingpong.save
        flash[:notice] = "Match sparad!"
        redirect_to pingis_url
      else
         render 'new'
      end
  end

  # PATCH/PUT /pingpongs/1
  # PATCH/PUT /pingpongs/1.json
  def update
    respond_to do |format|
      if @pingpong.update(pingpong_params)
        format.html { redirect_to @pingpong, notice: 'Pingpong was successfully updated.' }
        format.json { render :show, status: :ok, location: @pingpong }
      else
        format.html { render :edit }
        format.json { render json: @pingpong.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pingpongs/1
  # DELETE /pingpongs/1.json
  def destroy
    @pingpong.destroy
    respond_to do |format|
      format.html { redirect_to pingpongs_url, notice: 'Pingpong was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pingpong
      @pingpong = Pingpong.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pingpong_params
      params.require(:pingpong).permit(:winner, :looser, :sets_p1, :sets_p2)
    end
end
