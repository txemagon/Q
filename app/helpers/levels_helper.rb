module LevelsHelper

	def show_checkbox level, area
         check_box_tag('level[area_ids][]', area.id,
                           level.areas.include?(area),
                           id: dom_id(area) ) +
         label_tag(dom_id(area), pretty(area.name))
	end

    # Traverses the tree from a given node
	def traverse_tree(roots, final="", &block)
		roots = [roots] unless roots.is_a? ActiveRecord::Relation
		roots.each do |from|
			final << "<div class='Tree'>"
			final << capture(from, &block)
			from.children.each do |c|
				final << traverse_tree(c, &block)
			end unless from.leaf?
	        final << "</div>"
		end
		final.html_safe
	end
end
