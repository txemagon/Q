module GeneralTreeHelper

	def show_checkbox category, related
		category_name = category.class.name.underscore
		related_name = related.class.name.underscore
         check_box_tag("#{category_name}[#{related_name}_ids][]", related.id,
                           category.send(related_name.pluralize).include?(related),
                           id: dom_id(related) ) +
         label_tag(dom_id(related), pretty(related.name))
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