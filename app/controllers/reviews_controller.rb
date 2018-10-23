class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find_by(id: params[:id])
  end

  def new
    @review = Review.new

    if @review.save
      flash[:success] = "Successfully created a new review"
      redirect_to root_path

    else
      flash.now[:warning] = "An error occurred: could not create review"
      flash.now[:validation_errors] =
      @review.errors.full_messages

      render :new, status: :bad_request
    end
  end

  def create
    @review = Review.new

    if @review.save
      flash[:success] = "Thanks for creating a review!"

      redirect_to root_path

    else
      flash.now[:warning] = "An error occurred, could not create the review"
      flash.now[:validation_errors] = @review.errors.full_messages

      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
