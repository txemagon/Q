require 'highline/import'

class DbManager

  	def scope(data)
  		Scope.delete_all
      say "Populating Scopes"
  		populate_scopes(data)
  	end

  	def method_missing(method_name, *args)
  		say "<%= color('Undefined action for <#{method_name}>', :red) %>"
  	end

  	private

  	def populate_scopes(scope, parent=nil)
  		scope.each do |name, value|
          human_name = name.humanize.split.map(&:capitalize).join(' ')
  		    record = Scope.create!( :name => human_name)
  		    record.move_to_child_of(parent) if parent
          say "Creating #{' ' + parent.name + ': ' if parent}#{human_name}"
  		    populate_scopes(value, record)
  		end
  	end

  end