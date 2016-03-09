class Contact < ActiveRecord::Base
  belongs_to :organization

  Available=1
  NotAvailable=2
  FreidnlyStatusName={Available=>'Available',NotAvailable=>'Not Available'}

  def full_name
    "#{first_name} #{last_name}"
  end

end
