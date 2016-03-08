class Contact < ActiveRecord::Base
  belongs_to :organization

  def full_name
    "#{first_name} #{last_name}"
  end

end
