json.array!(@roles) do |role|
  json.extract! role, :id, :name, :parent, :lft, :rgt, :depth, :children_count
  json.url role_url(role, format: :json)
end
