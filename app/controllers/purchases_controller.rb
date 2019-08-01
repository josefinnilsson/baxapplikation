class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:index, :show, :edit, :update, :destroy]

  # GET /purchases
  # GET /purchases.json
  def index
    team = SessionsController.helpers.current_team
    purchases = Purchase.where(team_id: team.id)
    @purchases = purchases
    @purchases_grouped = purchases.group_by(&:product).to_h
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    team = SessionsController.helpers.current_team
    @products = Product.where(team_id: team.id)
    @products.each do |p|
      p.set_price
    end
    @purchase = Purchase.new
  end

  # GET /purchases/1/edit
  def edit
  end

  def create
    params[:antal].to_i.times do |purchase|
      purchase = Purchase.new(purchase_params)
      purchase.save
    end
    flash[:notice] = "Streck check!"
    redirect_to root_url
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    def authorize
      unless current_user.admin?
        redirect_to root_path, notice: 'Det är bara Baxmor som får vara där!'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:product_id, :user_id)
    end
end
