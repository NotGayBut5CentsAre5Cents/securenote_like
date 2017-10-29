json.extract! note, :id, :content, :slug, :created_at, :updated_at
json.url note_url(note, format: :json)
