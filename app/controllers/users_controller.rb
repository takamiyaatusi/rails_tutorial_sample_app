class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :already_signed, only: [:new, :create]
  before_action :protect_from_delete,  only: :destroy

  def new
   @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success]="Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end


  private

   def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end

  #before actions


   def correct_user
     @user = User.find(params[:id])
     redirect_to(root_path) unless current_user?(@user)
   end

   def admin_user
     redirect_to(root_path) unless current_user.admin?
   end

   def already_signed
     redirect_to(root_path) if signed_in?
   end

   def protect_from_delete
     @user = User.find(params[:id])
     if @user[:admin]
      flash[:error] = "管理者は削除できません。"
      redirect_to users_url
     end
   end


end
