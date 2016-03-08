class OrganizationsController < ApplicationController
  before_action :set_organization, except:  [:new,:create,:index]
  before_action :set_tag_params , only: [:add_problem,:add_app_area,:add_tech_area]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @organization=Organization.includes(:notes=>[:user]).find(params[:id])
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end


  def add_tech_area
    Organization.transaction do
      @organization.tech_areas.add(params[:tag]) if params[:tag].present?
      @organization.tech_areas.remove(params[:previous_tag]) if params[:previous_tag].present?
      @organization.save
    end
  end

  def add_app_area
    Organization.transaction do
      @organization.app_areas.add(params[:tag]) if params[:tag].present?
      @organization.app_areas.remove(params[:previous_tag]) if params[:previous_tag].present?
      @organization.save
    end
  end


  def add_problem
    Organization.transaction do
      @organization.app_areas.add(params[:tag]) if params[:tag].present?
      @organization.app_areas.remove(params[:previous_tag]) if params[:previous_tag].present?
      @organization.save
    end
  end

  def add_note
    note=Note.new(note_params)
    note.user=current_user
    note.save
    render :json=>{:response=>'SUCCESS'} and return  if note.persisted?
    render :json=>{:response=>'ERROR'} and return if note.persisted?
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_params
    params.require(:organization).permit(:name, :organization_type_id, :address, :about, :user_id,:tag_list,:logo)
  end

  def set_tag_params
      params[:tag].strip! if params[:tag]
      params[:previous_tag].strip! if params[:previous_tag]
  end

  def note_params
    params.require(:note).permit(:description)
  end
end
