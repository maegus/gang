class UsersController < ApplicationController
  before_action :set_user,
                only: %i[show update destroy]

  def index
    @users = User.all
    render json: @users
  end
  
  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:avatar, :nickname, :wechat, :mobile,
                                 :name, :gender, :school, :grade, :major,
                                 :complete) # exclude :admin
  end
end
