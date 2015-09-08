json.array!(@register_models) do |register_model|
  json.extract! register_model, :id, :name, :explanation
  json.url register_model_url(register_model, format: :json)
end
