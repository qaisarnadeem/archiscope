class UsersController < ApplicationController
  before_action :set_user ,except: [:index]
  load_and_authorize_resource


  def index
    authorize! :create, User
    @users=User.find_by_query(params[:q]).paginate(page:params[:page],:per_page=>15)
  end

  def block
     @user.update_attributes(is_blocked: true)
     redirect_to :back ,notice: "#{@user.full_name} has successfully been blocked"
  end

  def un_block
    @user.update_attributes(is_blocked: false)
    redirect_to :back ,notice: "#{@user.full_name} has successfully been un blocked"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end


end
