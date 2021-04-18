class UsersController < ApplicationController

  def summary
    respond_to do |format|
      if user_signed_in?
        format.html { render :show, notice: "definitely works" }
        format.json { render :show, status: :created, location: User }
      else
        format.html { redirect_to restaurants_url, notice: "Please sign in" }
        format.json { render json: User.errors, status: :unprocessable_entity }
      end
    end
  end
end
