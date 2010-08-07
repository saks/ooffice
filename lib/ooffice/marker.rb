module OOffice
	class Marker
		attr_reader :text_node, :replace_range

		def initialize(text_node, match_data)
			@text_node  = text_node
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

