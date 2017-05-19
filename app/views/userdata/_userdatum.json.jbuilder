json.extract! userdatum, :id, :name, :comment, :created_at, :updated_at
json.url userdatum_url(userdatum, format: :json)