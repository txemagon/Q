class Level < ActiveRecord::Base
	acts_as_nested_set
	include TheSortableTree::Scopes

	has_and_belongs_to_many :areas

    validates :name, uniqueness: true

    def title
    	name
    end

    def parent_name
    	return "No Parent" if root?
    	return parent.name
    end

    # True if an area that comes from given area
    # is offered in this level or any of the sublevels
    def offers? area
         area = normalize(area)
         self.self_and_descendants.inject(false) do |found, level|
            level.areas.inject(found) do |found, a|
                found || a.comes_from?(area)
            end
         end
    end

    # True if
    # all of the sublevels have at least one area that comes from given area.
    def has? area
        area = normalize(area)
        self.children.inject(true) do |all, ch|
            all &&
            ch.self_and_descendants.inject(false) do |some, level|
                some || level.areas.inject(some) { |some, ar| some || ar.comes_from?(area) }
            end
        end
    end

    # find a record using record name or acronym
    def find_me name

    end

    private

    def normalize area
        area = area.to_s if area.is_a? Symbol
        area = Area.find_by(name: area) if area.is_a? String
        area
    end
end
