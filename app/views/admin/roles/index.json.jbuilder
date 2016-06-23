json.array!(@roles) do |role|
  json.extract! role, :id
  json.url admin_role_url(role, format: :json)
end
