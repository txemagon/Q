module RegisterModelsHelper

	def link_to_first_version (model)
		  version = model.versions.first
		  first_version = YAML.load(version.next.object)
		  name = first_version['name'] + " v0"
	      filename = first_version['document_file_name']
	      filename = filename.split('.')
	      filename = filename.join('_v0.')
	      link_to name, "#{RegisterModel::DOCUMENT_PATH}/#{filename}"
	end
end
