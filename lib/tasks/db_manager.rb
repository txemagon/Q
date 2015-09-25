require 'highline/import'

class DbManager

  	def level(data)
  		Level.delete_all
      say "Populating Levels"
  		populate_levels(data)
  	end

  	def method_missing(method_name, *args)
  		say "<%= color('Undefined action for <#{method_name}>', :red) %>"
  	end

  	private

  	def populate_levels(level, parent=nil)
  		level.each do |name, value|
          human_name = name.humanize.split.map(&:capitalize).join(' ')
  		    record = Level.create!( :name => human_name)
  		    record.move_to_child_of(parent) if parent
          say "Creating #{' ' + parent.name + ': ' if parent}#{human_name}"
  		    populate_levels(value, record)
  		end
  	end

  end