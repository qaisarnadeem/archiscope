class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  validates_presence_of :description
end
