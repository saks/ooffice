module OOffice
	class Marker

		# Will be raised if document object already has accessor with name wich
		# equals to marker name
		class ForbiddenMarkerName < Exception; end

		attr_reader :text_node, :replace_range

		def initialize(text_node, marker_string)
			@text_node     = text_node
			@marker_string = marker_string

			@replace_range = calculate_replace_range
		end

		def replace(text)
			_content = @text_node.content
			_content[@replace_range] = text
			@text_node.content = _content
		end

		def calculate_replace_range
			start  = @text_node.content.index @marker_string
			finish = start + @marker_string.size

			start ... finish
		end

	end
end

