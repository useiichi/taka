json.array!(@messages) do |message|
  json.extract! message, :userid, :body
  json.url message_url(message, format: :json)
end
