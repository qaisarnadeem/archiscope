class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :organizations,dependent: :destroy
  has_many :notes ,dependent: :destroy
  attr_accessor :avatar
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/:style/profile.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
