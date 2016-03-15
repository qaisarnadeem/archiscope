class Contact < ActiveRecord::Base
  belongs_to :organization

  Available=1
  NotAvailable=2
  FreidnlyStatusName={Available=>'Available',NotAvailable=>'Not Available'}

  validates_presence_of :first_name,:last_name
  validates_uniqueness_of :email,scope:[:organization_id]

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_available?
    status_id == Available
  end

end
