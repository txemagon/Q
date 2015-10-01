# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderSortableTreeHelper
  module Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options
        node = options[:node]

        "
          <li data-node-id='#{ node.id }'>
            <div class='item'>
              <i class='handle'></i>
              #{ show_link }
              #{ show_relations if options[:linked_with]}
              #{ controls }
            </div>
            #{ children }
          </li>
        "
      end

      def show_link
        node = options[:node]
        ns   = options[:namespace]
        url = h.url_for(:controller => options[:klass].pluralize, :action => :show, :id => node)
        title_field = options[:title]

        "<h4>#{ h.link_to(node.send(title_field), url) }</h4>"
      end

      def show_relations
        node = options[:node]
        relation = options[:linked_with]
        related_model = relation.to_s.classify.constantize
        related = node.send(relation).group_by(&:parent)
        # related_model.all
        final_string = ""
        final_string << "<table>"
        related.each do |category, rel|
          final_string << "<tr><td>"
          final_string << "<em> #{h.pretty category.name}: </em>"
          final_string << "</td><td>"
          rel.each do |rel|
              final_string <<  "&nbsp;&nbsp;" <<
                h.check_box_tag("#{options[:klass].downcase}[#{relation.to_s}_ids][]",
                rel.id, related.include?(rel),
                id: h.dom_id(rel, h.dom_id(node)),
                disabled: true) <<
              " " <<
              (h.label_tag h.dom_id(rel, h.dom_id(node)), Formatter.show(rel.name))
          end
          final_string << "</td></tr>"
        end
        final_string << "</table>"
        final_string
      end

      def controls
        node = options[:node]

        edit_path = h.url_for(:controller => options[:klass].pluralize, :action => :edit, :id => node)
        destroy_path = h.url_for(:controller => options[:klass].pluralize, :action => :destroy, :id => node)

        "
          <div class='controls'>
            #{ h.link_to '', edit_path, :class => :edit }
            #{ h.link_to '', destroy_path, :class => :delete, :method => :delete, :data => { :confirm => 'Are you sure?' } }
          </div>
        "
      end

      def children
        unless options[:children].blank?
          "<ol class='nested_set'>#{ options[:children] }</ol>"
        end
      end

    end
  end
end
