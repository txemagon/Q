class Area < ActiveRecord::Base
	acts_as_nested_set
	include TheSortableTree::Scopes

	has_and_belongs_to_many :levels

    validates :name, uniqueness: true

    def title
    	name
    end

    def parent_name
    	return "No Parent" if root?
    	return parent.name
    end
end
