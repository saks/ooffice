# encoding utf-8

module OOffice
	class Presentation < Base

		attr_reader :markers

		def initialize(source)
			super(source)

			@markers = parse_and_generate_markers
		end

		def parse_and_generate_markers
			result = {}

			@xml.search('.//text:span', './/text:p').find_all do |el|
				match = (el.children   and  # element has a children
				1 == el.children.size and  # element has only one child
				el.child.text?        and  # element's child is a text node
				MARKER_RE.match el.content) or nil # element's context has markers

				if match and name = match[:name]
					result[name] = Marker.new el, match
				end
			end

			result
		end

	end # end of class Presentation
end # end of module OOFfice

