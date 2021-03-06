class UsersController < ApplicationController
  before_action :logged_in?, except: [:new, :create]

  def index
    @current_user = current_user
    @users_ = User.all
    @users_sorted = @users_.sort_by { |user| user.posts.count }
    @users = @users_sorted.reverse!
    render :index
  end

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.create(user_params)
    login user
    flash[:success] = "<span id='check'>&#x2713;</span> | Success! Welcome, Drifter!"
    redirect_to user
  end

  def show
    @current_user = current_user
    @user = User.find(params[:id])
    @posts = Post.all
    render :show
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    user = User.find(params[:id])
    user.update_attributes!(user_params)
    redirect_to user
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :about_me, :avatar_url)
  end
end
