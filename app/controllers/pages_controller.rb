class PagesController < ApplicationController
  def home
  @titre="acceuil"
  if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
  end
  end

  def contact
  @titre="contact"
  end

  def about
  @titre="about"
  end
  
  def help
    @title = "Aide"
  end
end

