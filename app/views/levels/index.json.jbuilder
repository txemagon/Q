json.array!(@levels) do |level|
  json.extract! level, :id, :name, :parent_id, :lft, :rgt, :depth, :children_count
  json.url level_url(level, format: :json)
end
