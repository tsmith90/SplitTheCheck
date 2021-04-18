class UsersController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update ]
  before_action :authenticate_user!, except: [:show, :index, :search]
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token



  def summary
    redirect_to(summary_path)
  end

end
