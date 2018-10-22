class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :find_categories, only: [:new, :edit, :update, :create]
#  before_action :find_seller, only: [:new, :edit, :update, :create]

  def index
    @products = Product.all
    @order_product = OrderProduct.new()
  end

  def show
    @order_product = OrderProduct.new()
  end

  def new
    if @login_user.nil?
      flash[:warning] = "You must be a merchant to sell a product. Sign up as a merchant to continue!"
      redirect_to root_path
    elsif !@login_user.is_a_seller?
      flash[:warning] = "You must be a merchant to sell a product. Sign up as a merchant to continue!"
      redirect_to user_path(@login_user.id)
    end
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

        render :new, status: :bad_request
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

  def find_categories
    @product_categories = Product.categories
  end

  def product_params
    return params.require(:product).permit(:name, :user_id, :price_in_cents, :category, :quantity, :description)
  end

  # def find_seller
  #   if @login_user.is_a_seller?
  #     return @seller = @login_user #this might nto be necessary but for explicitness rn
  #   end
  # end
end
