module EnvironmentVariablesLoader

  class Application < Rails::Application
      config.before_configuration do
        env_file = Rails.root.join("config", 'environment_variables.yml').to_s

        if File.exists?(env_file)
          data = YAML.load_file(env_file)
          [Rails.env, :global]. each do |environment|
              data[environment].each { |key, value| ENV[key.to_s] = value }
          end
        end

      end

  end # end class
end # end module