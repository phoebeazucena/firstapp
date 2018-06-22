class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /products
  # GET /products.json
  def index
    logger.debug "10 products per page"
    if params[:q]
      search_term = params[:q]
      @products = Product.search(search_term).paginate(page: params[:page], per_page: 10)
      logger.debug "product: #{@products}"
    else
      @products = Product.all.paginate(page: params[:page], per_page: 10)
      logger.debug "product: #{@products}"
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @comments = @product.comments.order("created_at DESC")
    @comments = @product.comments.paginate(page: params[:page], per_page: 5)
    logger.debug "comment: #{@comments}"
  end


  # GET /products/new
  def new
    if signed_in? && current_user.admin?
      @product = Product.new
    else
      redirect_to main_app.root_url, alert: "You are not authorized to view this page"
    end
  end

  # GET /products/1/edit

  def edit
    if signed_in? && current_user.admin?
    else
      redirect_to main_app.root_url, alert: "You are not authorized to view this page"
    end
  end


  # POST /products
  # POST /products.json
  def create
    if signed_in? && current_user.admin?
      @product = Product.new(product_params)

      respond_to do |format|
        if @product.save
          format.html { redirect_to @product, notice: 'Product was successfully created.' }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to main_app.root_url, alert: "You are not authorized to view this page"
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if signed_in? && current_user.admin?
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to '/simple_pages/landing_page', notice: 'Product was successfully updated.' }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { render :edit }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to main_app.root_url, alert: "You are not authorized to view this page"
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    if signed_in? && current_user.admin?
      @product.destroy
      respond_to do |format|
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to main_app.root_url, alert: "You are not authorized to view this page"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :image_url, :colour, :price)
    end
end
