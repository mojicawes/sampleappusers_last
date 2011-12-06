class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  def new   # responds to get /users/new by rendering new.html.erb
    @title = "Sign up"
    @user = User.new
  end
  
  def create  # responds to post /users and redirects to /user/i if successful or new.html.erb if not
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_path(@user)
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def show  # responds to get /user/i by rendering show.html.erb
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page] )
    @title = @user.name
  end
  
  def index  # responds to get /users by rendering index.html.erb
    @title = "Current users"
    @users = User.paginate(:page =>params[:page])
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page =>params[:page])
    render 'show_follow'
  end
  
   def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  private
     def authenticate
       deny_access unless signed_in? 
     end
     
     def correct_user
       @user = User.find(parms[:id])
       redirect_to(root_path) unless current_user?(@user)
     end

end
