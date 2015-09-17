module RegisterModelsHelper

    # Find how was the first version of model when more than one.
	def link_to_first_version (model)
		  version = model.versions.first
		  return "Current is the inital version." unless version.next
		  first_version = YAML.load(version.next.object)
		  name = first_version['name'] + " v0"
	      filename = first_version['document_file_name']
	      filename = filename.split('.')
	      filename = filename.join('_v0.')
	      link_to name, "#{RegisterModel::DOCUMENT_PATH}/#{filename}"
	end

    def creator_of (version)
    	user = User.find(version.whodunnit)
    	user = user.full_name if user
    	user || "Anonymous"
    end
end
