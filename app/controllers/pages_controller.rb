class PagesController < ApplicationController
  def home
    redirect_to courses_path if user_signed_in?
  end
end