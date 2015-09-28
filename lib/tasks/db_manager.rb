require 'highline/import'
require 'formatter'

class DbManager

    RELATION = {
      'area' => 'level'
    }

    # YAML send commands. Always singularized via rake task

    # Adds acronyms to the system
    def acronym(data)
      Formatter.add_acronym(data)
    end

    # Generic populate method
  	def populate(model, data)
  		model.delete_all
      say "<%= color('\nPopulating #{model.name.pluralize}', :yellow, :bold) %>"
  		populate_childs(model, data)
  	end

  	def method_missing(method_name, *args)
      table = method_name.to_s
      if %{area level}.include? table
        populate(eval(table.capitalize), *args)
      else
  		  say "<%= color('Dont know what to do with <#{table}>.', :red) %>"
      end
  	end

  	private

    # Links the new record with the array of parents.
    def concatenate(model, record, relations)
      relations.each do |r|
        say "<%= color('Linking #{ r } with #{ record.name }', :blue, :bold) %>"
         begin
            level = Level.find_by_name!(r.downcase)
            record.levels << level
         rescue Exception => e
           say "<%=  color('Could not find record #{r}', :red, :bold) %>"
         end
      end
    end

    # Makes a tree out of a YAML hash
  	def populate_childs(model, child, parent=nil)

  		child.each do |name, value|
          human_name = Formatter.sentence(name)
  		    record = model.create!( :name => human_name)
  		    record.move_to_child_of(parent) if parent
          say "Creating #{' ' + parent.name + ': ' if parent}#{human_name}"

  		    populate_childs(model, value, record) if value.is_a? Hash

          if value.is_a? Array
            concatenate(model, record, value)
          end

  		end
  	end

  end