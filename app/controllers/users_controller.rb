class UsersController < ApplicationController
  attr_accessor :remember_token

  def index
    @user = User.all
  end 

 def show
  @user = User.find(params[:id])
 end 

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome, sign up successful"
      redirect_to posts_path
    else
      render :new
    end 
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Confirms a logged-in user.
    # def logged_in_user
    #   unless logged_in?
    #     flash[:danger] = "Please log in."
    #     redirect_to login_url
    #   end
end
