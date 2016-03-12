class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new(:organization_id=>params[:organization_id])
    respond_to do |format|
      format.js
    end
  end

  # GET /contacts/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        format.js
      else
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_update_params)
        format.js
      else
        format.js { render :edit }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.js { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :status_id, :position,:organization_id,:referred_by)
  end
  def contact_update_params
    params.require(:contact).permit(:first_name, :last_name, :email, :status_id, :position,:referred_by)
  end
end
