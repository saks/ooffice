# encoding utf-8

module OOffice
	class Presentation < Base
		attr_reader :markers, :tables

		def initialize(source, name)
			super(source, name)

			@markers = parse_and_generate_markers
			@tables  = parse_and_generate_marked_tables
		end

		def self.instantiate(source, name)
			obj = self.new(source, name)
			obj.assign_setter_merthods
			obj
		end

		def parse_and_generate_markers
			result = {}
			@xml.traverse do | node |
				if node.text? and
						node.content.include?('__') and
						(matches = node.content.scan MARKER_RE).size > 0

					matches.each do | marker_string, name |
						result[name] ||= []
						result[name] << Marker.new(node, marker_string)
					end
				end
			end

			result
		end

		def parse_and_generate_marked_tables
			tables = Tables.new
			@xml.search('.//draw:frame').each do |el|
				name_attr = el.attributes['name']
				if name_attr and name_attr.value.include?('table::')
					name = name_attr.value.split('::').last

					tables[name] = DataTable.new el.search('.//table:table').first
				end
			end
			tables
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

		class Tables# < BasicObject
			def initialize
				@tables = {}
			end

			def []=(table_name, table)
				@tables[table_name.to_s] = table
			end

			def method_missing(meth, *args, &block)
				if table = @tables[meth.to_s]
					table.replace *args
				else
					raise ArgumentError.new "There is now table with #{meth}. Available table names: #{@tables.keys}"
				end
			end
		end

	end # end of class Presentation
end # end of module OOFfice

