class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  ADMIN=1
  NormalUser=2
  RolesFriendlyName={ADMIN=>'Admin',NormalUser=>'User'}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :organizations,dependent: :destroy
  has_many :notes ,dependent: :destroy
  attr_accessor :avatar


  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/:style/profile.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :avatar, :in => 0.megabytes..1.megabytes
  validates_presence_of :first_name,:last_name
  before_save :set_role

  def is_admin?
    self.role_id == ADMIN
  end

  def normal_user?
    self.role_id == NormalUser
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_active?
    !is_blocked?
  end

  def active_for_authentication?
    super && is_active?
  end

  def role_name
    RolesFriendlyName[self.role_id]
  end

  def inactive_message
    is_active? ? super : "Your account is blocked please contact administrator"
  end

  def self.find_by_query query
    return User if query.blank?
     self.where("LOWER(email) LIKE (?) or LOWER(concat (concat(first_name,' '),last_name)) like (?)","%#{query.to_s.downcase}%","%#{query.to_s.downcase}%")
  end

  private
  def set_role
    self.role_id=NormalUser if self.role_id.blank?
  end
end
