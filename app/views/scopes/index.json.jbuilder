json.array!(@scopes) do |scope|
  json.extract! scope, :id, :name, :parent_id, :lft, :rgt, :depth, :children_count
  json.url scope_url(scope, format: :json)
end
