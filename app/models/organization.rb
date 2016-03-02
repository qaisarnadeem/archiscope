class Organization < ActiveRecord::Base
  belongs_to :user
  has_many :notes,dependent: :destroy
  acts_as_taggable_on :technology_areas,:application_areas,:problems
  attr_accessor :logo
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  Company=1
  GovernmentAgency=2
  InvestmentGroup=3
  OrganizationTypesFriendlyNames={Company=>'Company',GovernmentAgency=>'Government Agency',InvestmentGroup=>'Investment Group'}
  OrganizationTypesColors={Company=>'green',GovernmentAgency=>'red',InvestmentGroup=>'blue'}
end
