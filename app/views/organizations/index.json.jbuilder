json.array!(@organizations) do |organization|
  json.extract! organization, :id, :name, :organization_type_id, :address, :about, :user_id
  json.url organization_url(organization, format: :json)
end
