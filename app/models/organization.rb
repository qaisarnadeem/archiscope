class Organization < ActiveRecord::Base
  include FriendlyId
  belongs_to :user
  has_many :notes ,->{order(:updated_at=>:desc)},dependent: :destroy
  has_many :contacts
  acts_as_taggable_on :technology_areas,:application_areas,:problems
  attr_accessor :logo
  friendly_id :name , use: :slugged
  validates_presence_of :name,:organization_type_id
  validates_uniqueness_of :name, :case_sensitive => false
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "112x112>" }, default_url: "/assets/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  Company=1
  GovernmentAgency=2
  InvestmentGroup=3
  OrganizationTypesFriendlyNames={Company=>'Company',GovernmentAgency=>'Government Agency',InvestmentGroup=>'Investment Group'}
  OrganizationTypesColors={Company=>'purpal_bg',GovernmentAgency=>'info_bg',InvestmentGroup=>'green_bg'}
  ProblemKeyWord='problems'
  AppKeyWord='application_areas'
  TechKeyWord='technology_areas'


  def tech_areas
    self.technology_area_list
  end


  def type_class
    OrganizationTypesColors[self.organization_type_id]
  end

  def type_name
    OrganizationTypesFriendlyNames[self.organization_type_id].to_s.parameterize
  end


  def app_areas
    self.application_area_list
  end

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end

  def last_updated_at
    self.updated_at.strftime("%B %d, %Y")
  end

  def total_tags_count
    self.problems.count + self.technology_areas.count + self.application_areas.count
  end

  def self.find_by_tags tag_name,tag_type=nil
    return Organization.order('random()') unless tag_name.present?
    unless tag_type.present?
      ids1=Organization.select(:id).where("LOWER(name) like LOWER(?)","%#{tag_name}%").map &:id
      ids2=Organization.tagged_with([tag_name],:wild=>true,:any=>true).select(:id).map &:id
      return Organization.where(:id=>(ids1 | ids2))
    end
    return Organization.tagged_with([tag_name],:wild=>true,:any=>true) unless tag_type.present?
    Organization.tagged_with([tag_name],:wild=>true,:on=>tag_type,:any=>true)
  end

  def self.tags_count_by_context
    ActsAsTaggableOn::Tagging.group(:context).count
  end

  def find_all_matching_tags name,context=nil
    return ActsAsTaggableOn::Tagging.includes(:tag).where("name like ? ","'#{name}%'").order(:name).uniq unless context
    ActsAsTaggableOn::Tagging.includes(:tag).where(context: context).where("name like ? ","'#{name}%'").order(:name).uniq
  end

  def self.all_tech_areas_categorized
    ActsAsTaggableOn::Tagging.
        select('taggings.context, tags.name as tag_name,organizations.organization_type_id as organization_type_id,
                count(taggings.id) as count_all').
        joins(:tag).joins('inner join organizations on organizations.id = taggable_id').where(:taggable_type=>"Organization").
        group('taggings.context, tags.name,organizations.organization_type_id').group_by &:context
  end

  def get_complete_url
    return "http://#{self.url}" unless self.url.blank? || self.url.start_with?("http")
    return self.url
  end

end
