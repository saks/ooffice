module OOffice
	class Marker
		attr_reader :element, :replace_range, :text_node

		def initialize(element, match_data)
			@element    = element
			@text_node  = @element.child
			@match_data = match_data

			@replace_range = calculate_replace_range
		end

		def replace(text)
			_content = @text_node.content
			_content[@replace_range] = text
			@text_node.content = _content
		end

		def calculate_replace_range
			offset = @match_data.offset 1

			offset[0] - 2 ... offset[1] + 2 # FIXME: remove hardcoded +- 2
		end

	end
end

