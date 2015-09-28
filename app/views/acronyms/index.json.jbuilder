json.array!(@acronyms) do |acronym|
  json.extract! acronym, :id, :key, :name, :expand
  json.url acronym_url(acronym, format: :json)
end
