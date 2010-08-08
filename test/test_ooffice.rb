require 'helper'

class TestOOffice < Test::Unit::TestCase

	context 'external api' do

		setup do
			@existing_path     = File.join Dir.pwd, 'test', 'assets', 'presentation.fodp'
			@not_existing_path = 'this_file_not_existst'
			@xml = IO.read @existing_path
		end

		should "accept only instance of File, text of xml document, nil, or empty string" do
			assert_nothing_raised(Exception) do
				OOffice::instantiate :Presentation, IO.read(@existing_path)
				OOffice::instantiate :Presentation, File.new(@existing_path)
			end

			assert_raise(Nokogiri::XML::XPath::SyntaxError) do
				OOffice::instantiate :Presentation, ''
				OOffice::instantiate :Presentation, nil
			end

			assert_raise(Nokogiri::XML::SyntaxError) do
				OOffice::instantiate :Presentation, 'not an xml document'
			end

		end

		should "do all substitutions with presentation" do
			presentation = OOffice::Presentation @xml

			presentation.module = 'my favourite module'

			presentation.tables.sex_and_age [ [9, 10], [8, 9], [7, 8], [6, 7] ]

			result = presentation.to_xml

			assert_no_match /__module__/,      result
		end

	end

end

