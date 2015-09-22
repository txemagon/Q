class Scope < ActiveRecord::Base
	acts_as_nested_set 
	include TheSortableTree::Scopes

    def title
    	name
    end

    def parent_name
    	return "No Parent" if root?
    	return parent.name
    end
end
