require 'yaml'
require 'highline/import'

POPULATE_DIR = File.join(Rails.root, 'db', 'data')

namespace :db do

  class DbManager

  	def scope(data)
  		Scope.delete_all
  		populate_scopes(data)
  	end

  	def method_missing(method_name, *args)
  		say "<%= color('Undefined action for <#{method_name}>', :red) %>"
  	end

  	private

  	def populate_scopes(scope, parent=nil)
  		scope.each do |name, value|
  		    record = Scope.create!(
  		    	:name => name.humanize.split.map(&:capitalize).join(' ') )
  		    record.move_to_child_of(parent) if parent
  		    populate_scopes(value, record)
  		end
  	end

  end

  desc "Populate initial data with yaml files inside db/data."
  task :populate_for => :environment do
  	manager = DbManager.new
  	possibilities = Dir.glob( File.join(POPULATE_DIR, '*.yml'))

  	option = File.join(POPULATE_DIR, ask_alternatives(possibilities))
  	data = YAML.load_file(option)

  	data.each do |scope, data|
  		manager.send(scope.to_s.singularize.to_sym, data)
  	end
  end

  # output possibilities
  def ask_alternatives(possibilities)
    say	"\n<%= color('Choose a file to seed from.', :bold) %>"

  	choose do |menu|
        menu.header = "Available files"
  		menu.prompt = "Type filename or choose option number:"
  		menu.choices *possibilities.map{ |x| File.basename x}
  	end
  end

  def show(data, parent=nil)
  	data.each do |key, value|
  		print "#{parent}: " if parent
  		print "#{key}"
  		puts
  		show value, key unless value.empty?
  	end
  end

end
