class PagesController < ApplicationController
  def home
  @titre="acceuil"
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

