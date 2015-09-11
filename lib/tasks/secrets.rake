USER = "txemagon"
TARGET = "variables.tgz.pgp"
DEPENDENCIES = ["config/secrets.yml", "config/enviroment_variables.yml"]

namespace :secrets do
  desc "Encrypts sensitive data for uploading to a public repository."
  task fold: :environment do
  	existing_deps = []
  	DEPENDENCIES.each { |dep| existing_deps << dep if File.exists?(dep)}

  	unless existing_deps.empty?
  	  sh "tar cvzf -  #{existing_deps.join(" ")} | gpg -e -r #{USER} -o #{TARGET}"
  	end

  end

  desc "Decrypts sensitive data after downloading from a public repository."
  task unfold: :environment do
  	if (File.exists?(TARGET))
    	sh "gpg --decrypt #{TARGET} | tar xvzf -"
  	    sh "rm #{TARGET}"
   end
  end

end
