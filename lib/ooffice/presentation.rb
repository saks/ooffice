# encoding utf-8

module OOffice
	class Presentation < Base

		attr_reader :markers

		def initialize(source)
			super(source)

			@markers = parse_and_generate_markers
		end

		def self.instantiate(source)
			obj = self.new(source)
			obj.assign_setter_merthods
			obj
		end

		def parse_and_generate_markers
			result = {}
			@xml.traverse do | node |
				if node.text? and
						node.content.include?('__') and
						match = MARKER_RE.match(node.content)

					name = match[1]
					result[name] ||= []
					result[name] << Marker.new(node, match)
				end
			end

			result
		end

		def assign_setter_merthods
			@markers.each do | name, markers |
				self.define_singleton_method "#{name}=" do | new_text |
					markers.each do | marker |
						marker.replace new_text
					end
				end
			end
		end

	end # end of class Presentation
end # end of module OOFfice

