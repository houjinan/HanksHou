class HomeController < ApplicationController

  def index
    cookies["nav_active"] = "index"
    redirect_to articles_path
  end

  def about_me
    cookies["nav_active"] = "about"
    render "about_me", layout: "about_me"
  end

end
