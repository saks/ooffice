require 'helper'

class TestDataTable < Test::Unit::TestCase



	context 'data table' do
		setup do
			@xml = Nokogiri::XML '<document
			xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
			xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
			xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0">

				<table:table table:name="local-table">
						<table:table-header-columns>
						  <table:table-column/>
						</table:table-header-columns>
						<table:table-columns>
						  <table:table-column table:number-columns-repeated="2"/>
						</table:table-columns>
						<table:table-header-rows>
						  <table:table-row>
						      <table:table-cell>
						        <text:p/>
						      </table:table-cell>
						      <table:table-cell office:value-type="string">
						        <text:p>Column 1</text:p>
						      </table:table-cell>
						      <table:table-cell office:value-type="string">
						        <text:p/>
						      </table:table-cell>
						  </table:table-row>
						</table:table-header-rows>
						<table:table-rows>
						  <table:table-row>
						      <table:table-cell office:value-type="string">
						        <text:p/>
						      </table:table-cell>
						      <table:table-cell office:value-type="float" office:value="1">
						        <text:p>1</text:p>
						      </table:table-cell>
						      <table:table-cell office:value-type="float" office:value="22">
						        <text:p>22</text:p>
						      </table:table-cell>
						  </table:table-row>
						  <table:table-row>
						      <table:table-cell office:value-type="string">
						        <text:p>Row 2</text:p>
						      </table:table-cell>
						      <table:table-cell office:value-type="float" office:value="2">
						        <text:p>2</text:p>
						      </table:table-cell>
						      <table:table-cell office:value-type="float" office:value="33">
						        <text:p>33</text:p>
						      </table:table-cell>
						  </table:table-row>
						  <table:table-row>
						      <table:table-cell office:value-type="string">
						        <text:p>Row 3</text:p>
						      </table:table-cell>
						      <table:table-cell office:value-type="float" office:value="3">
						        <text:p>3</text:p>
						      </table:table-cell>
						      <table:table-cell office:value-type="float" office:value="44">
						        <text:p>44</text:p>
						      </table:table-cell>
						  </table:table-row>
						  <table:table-row>
						      <table:table-cell office:value-type="string">
						        <text:p>Row 4</text:p>
						      </table:table-cell>
						      <table:table-cell office:value-type="float" office:value="4">
						        <text:p>4</text:p>
						      </table:table-cell>
						      <table:table-cell office:value-type="float" office:value="55">
						        <text:p>55</text:p>
						      </table:table-cell>
						  </table:table-row>
						</table:table-rows>
				</table:table>
			</document>'
			@data_table = OOffice::DataTable.new @xml.at_xpath './/table:table'
		end

		should "parse rows" do
			assert_equal 4, @data_table.rows.size
			text_before   = @xml.xpath('.//table:table-cell[@office:value-type="float"]/text:p/text()').map(&:content)
			values_before = @xml.xpath('.//table:table-cell[@office:value-type="float"]/@office:value').map(&:value)

			assert_equal text_before, values_before

			@data_table.replace [
				[ 1, 11],
				[ 2, 22],
				[ 3, 33],
				[ 4, 44],
			]

			text_after   = @xml.xpath('.//table:table-cell[@office:value-type="float"]/text:p/text()').map(&:content)
			values_after = @xml.xpath('.//table:table-cell[@office:value-type="float"]/@office:value').map(&:value)
			assert_equal text_before, values_before
			assert_equal ["1", "22", "2", "33", "3", "44", "4", "55"], values_before
		end

	end

	context 'data table row' do

		setup do
			@xml = Nokogiri::XML '
<document
	xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
	xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
	xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0">

	<table:table-row>
		<table:table-cell office:value-type="string">
			<text:p/>
		</table:table-cell>
		<table:table-cell office:value-type="float" office:value="1">
			<text:p>1</text:p>
		</table:table-cell>
		<table:table-cell office:value-type="float" office:value="2">
			<text:p>2</text:p>
		</table:table-cell>
	</table:table-row>
</document>
'
			@row = OOffice::DataTable::Row.new @xml.at_xpath './/table:table-row'
		end

		should "parse cells" do
			assert_equal 2, @row.cells.size

			text_before   = @xml.xpath('.//table:table-cell/text:p/text()').map(&:content)
			values_before = @xml.xpath('.//table:table-cell/@office:value').map(&:value)
			assert_equal text_before, values_before
			assert_equal ['1', '2'], values_before


			@row.replace [11, 22]

			text_after   = @xml.xpath('.//table:table-cell/text:p/text()').map(&:content)
			values_after = @xml.xpath('.//table:table-cell/@office:value').map(&:value)
			assert_equal text_after, values_after
			assert_equal ['11', '22'], values_after
		end

		# TODO
	end

	context 'data table row cell' do

		setup do
			@xml = Nokogiri::XML '<document
			xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
			xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0">
<table:table-cell office:value-type="float" office:value="1">
	<text:p>1</text:p>
</table:table-cell>
</document>'
			@cell = OOffice::DataTable::Row::Cell.new @xml.at_xpath './/table:table-cell'
		end

		should "parse text element on initialize" do
			assert_equal '1', @cell.text_node.content
		end

		should "replace both office:value and text content" do
			@cell.replace 777.999

			new_doc = Nokogiri::XML @xml.to_s

			text = new_doc.at_xpath('.//text:p').child.content
			value = new_doc.at_xpath('.//table:table-cell').attributes['value'].value

			assert_equal '777.999', text
			assert_equal '777.999', value
		end

	end

end

