class ReviewsController < ApplicationController
    before_action :set_product, only: [:create]

    
    def create        
         @review = @product.reviews.new({
            user: current_user,
            description: params['description'],
            rating: params['rating']['rating_value']
        })


        if(@review.save)
            redirect_to root_path
        else
            
             render json: @review.errors, status: :unprocessable_entity 
            #redirect_to :back
        end

    end

    private
        def set_product
            @product = Product.find(params[:product_id])
        end
end
