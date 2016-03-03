class Organization < ActiveRecord::Base
  belongs_to :user
  has_many :notes,dependent: :destroy
  acts_as_taggable_on :technology_areas,:application_areas,:problems
  attr_accessor :logo

  validates_presence_of :name,:organization_type_id

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  Company=1
  GovernmentAgency=2
  InvestmentGroup=3
  OrganizationTypesFriendlyNames={Company=>'Company',GovernmentAgency=>'Government Agency',InvestmentGroup=>'Investment Group'}
  OrganizationTypesColors={Company=>'green',GovernmentAgency=>'red',InvestmentGroup=>'blue'}


  def tech_areas
    self.technology_area_list
  end


  def app_areas
    self.application_area_list
  end

  def find_all_matching_tags name,context=nil
    return ActsAsTaggableOn::Tagging.includes(:tag).where("name like ? ","'#{name}%'").order(:name).uniq unless context
    ActsAsTaggableOn::Tagging.includes(:tag).where(context: context).where("name like ? ","'#{name}%'").order(:name).uniq
  end

end
