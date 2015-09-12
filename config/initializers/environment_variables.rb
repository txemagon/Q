# module EnvironmentVariablesLoader

#   class Application < Rails::Application
#       config.before_configuration do

#         env_file = Rails.root.join("config", 'environment_variables.yml').to_s

#         raise "Could not load environment variables from #{env_file}" unless File.exists?(env_file)
#         data = YAML.load_file(env_file)

#         ['global', Rails.env].each do |environment|
#             data[environment].each { |key, value| puts key;ENV[key.to_s] = value }
#         end

#         puts "Enviroment varibles loaded"
#       end

#   end # end class
# end # end module