json.array!(@notes) do |note|
  json.extract! note, :id, :description, :user_id, :organization_id
  json.url note_url(note, format: :json)
end
