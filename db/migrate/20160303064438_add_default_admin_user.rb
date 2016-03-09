class AddDefaultAdminUser < ActiveRecord::Migration
  def change
    User.create(:email=>'admin@archiscope.com',:password=>'admin123',:first_name=>'Archiscope',:last_name=>'Admin',:role_id=>User::ADMIN)
  end
end
