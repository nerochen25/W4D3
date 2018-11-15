class UsersController < ApplicationController
  # def show
  #   @user = User.find(params[:id])
  #   render :show
  # end
  def show
    if current_user.nil?
      redirect_to session_url
      return
    end
  
    @user = current_user
    render :show
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      render :new
    end  
  end
  
  def new
    @user = User.new
    render :new
  end
  
  private
  def user_params
    self.params.require(:users).permit(:user_name, :password)
  end
end