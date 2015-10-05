class Role < ActiveRecord::Base
	acts_as_nested_set
	include TheSortableTree::Scopes

	validates :name, uniqueness: true

	def title
		name
	end

	def parent_name
    	return "No Parent" if root?
    	return parent.name
    end

end
