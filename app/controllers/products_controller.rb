class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new()
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = "Successfully created #{@product.name}"
      redirect_to product_path(@product.id)
    else
      flash.now[:warning] = "A problem occurred: Could not create #{@product.name}"
      flash.now[:validation_errors] = @product.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
        flash[:success] = "Successfully updated #{@product.name}"
        redirect_to product_path(@product.id)
    else
        flash.now[:warning] = "A problem occurred: Could not update #{@product.name}"
        flash.now[:validation_errors] = @product.errors.full_messages
        render :edit
    end
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
