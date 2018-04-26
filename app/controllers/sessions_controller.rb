class SessionsController < ApplicationController

    def new
    end

    def create
        @user = User.find_by_email(params[:email])
        # If the user exists and the password entered is correct
        auth = @user.authenticate(params[:password])
        if(@user && @user.authenticate(params[:password]))
            session[:user_id] = @user.id
            redirect_to '/'
        else
            redirect_to '/login'
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to '/'
    end
end
