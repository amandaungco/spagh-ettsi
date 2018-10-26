
class ReviewsController < ApplicationController
  before_action :find_product, only: [:new, :create]

  def index
    @reviews = Review.all
  end

  def new
    if item_ownership?
      redirect_to product_path(@product.id)
      flash[:warning] = "You cannot review your own products."
    else
      @review = @product.reviews.new
    end
  end

  def create
    if item_ownership?

      redirect_to product_path(@product.id)
      flash[:warning] = "You cannot review your own products."
    else

    @review = Review.new(review_params)
    @review.user = @login_user
      if @review.save
        flash[:success] = "Thanks for creating a review!"

        redirect_to product_path(@product.id)
      else

        flash[:warning] = "An error occurred, could not create the review"
        flash[:validation_errors] = @review.errors.full_messages

         redirect_to product_path(@product.id), status: :bad_request
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:review, :rating, :product_id)
  end

  def item_ownership?
    return @product.user_id == session[:user_id]
  end

  def find_product
    @product = Product.find_by(id: params[:id].to_i)

    if @product.nil?
      render 'layouts/not_found', status: :not_found
    end
  end
end
