json.array!(@areas) do |area|
  json.extract! area, :id, :name, :parent_id, :lft, :rgt, :depth, :children_count
  json.url area_url(area, format: :json)
end
