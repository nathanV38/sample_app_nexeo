class UsersController < ApplicationController
before_filter :authenticate, :except => [:show, :new, :create]
#before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
before_filter :correct_user, :only => [:edit, :update]
before_filter :admin_user,   :only => :destroy

  # GET /users
  # GET /users.json
  def index
    @titre = "Tous les utilisateurs"
    @users = User.paginate(:page => params[:page],:per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
	@microposts = @user.microposts.paginate(:page => params[:page],:per_page => 5)
	@titre=@user.nom

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @titre= "inscription"
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
	@titre = "Edition profil"
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
	    sign_in @user
        flash[:success] = "Bienvenue #{params[:user][:nom]}!"   #-> cf success ci dessous
        #format.html { redirect_to @user, notice:"test encard flash!"}
		format.html { redirect_to @user}
        format.json { render json: @user, status: :created, location: @user }
      else
	    @titre = "Inscription"
        format.html { render action: "new"}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Profil actualise' }
        format.json { head :no_content }
      else
	    @titre="Edition du profil"
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Utilisateur supprime"

    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end
  
  def following
    @titre = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page],:per_page=>5)
    render 'show_follow'
  end

  def followers
    @titre = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page],:per_page=>5)
    render 'show_follow'
  end
  
  
  
  
  private
   
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
      redirect_to(root_path) unless current_user.admin?
  end
end
