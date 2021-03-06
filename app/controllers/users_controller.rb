class UsersController < ApplicationController
  # before_action :authenticate_user!, :load_user, only: [:show]
  authorize_resource

  before_action :load_user, only: [:show]

  def show
    @orders = @user.orders.newest_time.page(params[:page])
                   .per(Settings.page.per_5)
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user.notfound"
    redirect_to root_path
  end
end
