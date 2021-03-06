class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from ActionController::RoutingError, :with =>:render_404
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  before_action :authenticate_user!

  def render_404
    render 'main/404' ,:status=>404,:formats=> nil and return
  end
end
