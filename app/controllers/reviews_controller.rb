class ReviewsController < ApplicationController

    def create
        @product = Product.find(params[:product_id])
         @review = @product.reviews.new({
            user: current_user,
            description: params['description'],
            rating: params['rating']['rating_value']
        })

        if(@review.save)
            redirect_to root_path
        else
            redirect_to :back
        end

    end
end
