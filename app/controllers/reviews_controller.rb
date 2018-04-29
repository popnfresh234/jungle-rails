class ReviewsController < ApplicationController
    before_filter :authorize
    before_action :set_product, only: [:create]
    before_action :set_product_delete, only: [:destroy]

    
    def create        
        @review = @product.reviews.new(review_params)
        @review.user = current_user
        respond_to do |format|
            if @review.save
            format.html { redirect_to @product, notice: 'Test was successfully created.' }
            format.json { render :show, status: :created, location: @review }
            else
            format.html { render :new }
            format.json { render json: @review.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @review.destroy
        redirect_to [@product], notice: 'Review deleted!'
    end

    private
        def review_params
            params.require(:review).permit(:rating, :description)
        end

        def set_product
            @product = Product.find(params[:product_id])
        end

        def set_product_delete
            
            @review = Review.find params[:id]
            @product = Product.find(@review.product_id)
        end
end
