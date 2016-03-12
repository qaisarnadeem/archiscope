class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :check_permissions
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  skip_before_filter :require_no_authentication ,:only => [:new,:create]
  before_action :authenticate_user!
  respond_to :json,:js
  # GET /resource/sign_up
  def new
    build_resource({})
    set_minimum_password_length
    yield resource if block_given?
    respond_to do |format|
      format.js
    end
  end

  # POST /resource
   def create
     params[:role_id]=User::NormalUser if params[:role_id].blank?
     build_resource(sign_up_params)

     resource.save
     yield resource if block_given?
     if resource.persisted?
       if resource.active_for_authentication?
         #set_flash_message! :notice, :signed_up
         sign_up(resource_name, resource)
         respond_to do |format|
           format.js
         end
       else
         #set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
         expire_data_after_sign_in!
         respond_to do |format|
           format.js
         end
       end
     else
       clean_up_passwords resource
       set_minimum_password_length
       respond_to do |format|
         format.js {render :new}
       end
     end
   end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
   def update
     self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
     params[:role_id]=resource.role_id unless current_user.is_admin?
     prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

     resource_updated = update_resource(resource, account_update_params)
     yield resource if block_given?
     if resource_updated
       if is_flashing_format?
         flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
             :update_needs_confirmation : :updated
         #set_flash_message :notice, flash_key
       end
       sign_in resource_name, resource, bypass: true
       respond_to do |format|
         format.js
       end
     else
       clean_up_passwords resource
       respond_to do |format|
         format.js {render :edit}
       end
     end
   end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

   protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :first_name << :last_name << :avatar << :role_id
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :first_name << :last_name << :avatar << :role_id
  end

  def check_permissions
    authorize! :create, resource if params[:action] =~ /(create)|(new)/i
    authorize! :update, resource if params[:action] =~ /(update)|(edit)/i
  end
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
