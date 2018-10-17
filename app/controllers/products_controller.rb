class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  def index
    @products = Product.all
  end

  def show; end

  def new
  end

  def create
  end

  def edit; end

  def update
  end

  def destroy
  end

  private

  def find_product
    @product = Product.find_by(id: params[:id].to_i)

    if @product.nil?
      render :notfound, status: :not_found
    end
  end

  def product_params
    return params.require(:product).permit(:name, :user_id, :price_in_cents, :category, :quantity, :description)
  end
end
