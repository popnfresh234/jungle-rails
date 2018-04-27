class ReviewsController < ApplicationController
    before_action :set_product, only: [:create]

    
    def create        
         @review = @product.reviews.new({
            user: current_user,
            description: params['description'],
            rating: params['rating']['rating_value']
        })



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

    private
        def set_product
            @product = Product.find(params[:product_id])
        end
end
