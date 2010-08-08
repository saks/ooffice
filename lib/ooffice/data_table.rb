module OOffice
	class DataTable

		attr_reader :rows

		def initialize(table_rows_element)
			@table_rows_element = table_rows_element
			@rows               = find_rows
		end

		def find_rows
			@table_rows_element.xpath('.//table:table-rows/table:table-row').map do | row |
				Row.new row
			end
		end

		def replace(new_rows)
			@rows.each_with_index do | row, i |
				row.replace new_rows[i]
			end
		end

		class Row
			attr_reader :cells

			def initialize(row_element)
				@row_element = row_element
				@cells       = find_cells
			end

			def find_cells
				@row_element.search('.//table:table-cell[@office:value-type="float"]').map do |el|
					Cell.new el
				end
			end

			def replace(new_row_data)
				@cells.each_with_index do | cell, i |
					cell.replace new_row_data[i]
				end
			end

			class Cell
				attr_reader :text_node

				def initialize(cell_element)
					@cell_element = cell_element
					@text_node    = @cell_element.at_xpath('.//text:p').child
				end

				def replace(new_value)
					@cell_element.attributes['value'].value = @text_node.content = new_value.to_s
				end

			end # end of class Cell
		end # end of class Row
	end # end of class DataTable
end # end of module OOffice

