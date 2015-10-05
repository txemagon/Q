class Area < ActiveRecord::Base
	acts_as_nested_set
	include TheSortableTree::Scopes

	has_and_belongs_to_many :levels

    validates :name, uniqueness: true
    validate :leaf_level

    def leaf_level
        unless self.leaf?
            errors.add(:base, 'Only terminal areas can be linked to levels' )
        end
    end

    def title
    	name
    end

    def parent_name
    	return "No Parent" if root?
    	return parent.name
    end


    # True if this area is descendant of given area or is the given area.
    def comes_from? area
        area = area.to_s if area.is_a? Symbol
        area = Area.find_by(name: area) if area.is_a? String

        self.self_and_ancestors.include? area
    end
end
