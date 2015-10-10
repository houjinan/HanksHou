class HomeController < ApplicationController
  #before_action :authenticate_user!
  def index
    cookies["nav_active"] = "index"
  end

  def feel
    cookies["nav_active"] = "feel"
  end

  def about_me
    render "about_me", layout: "about_me"
  end
end
