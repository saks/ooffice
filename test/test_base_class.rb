require 'helper'

class TestOOfficeBase < Test::Unit::TestCase

	class TEST_CLASS < OOffice::Base
		attr_reader :xml, :file

		def initialize(file_or_file_name)
			@file = file_or_file_name
		end

	end

	context 'parse_xml method' do
		setup do
			@template_path = File.join Dir.pwd, 'test', 'assets', 'presentation.fodp'
		end

		should "parse xml file into Nokogiri::XML::Document" do
			xml_document = TEST_CLASS.new(@template_path).parse_xml
			assert_instance_of Nokogiri::XML::Document, xml_document
		end
	end

	context 'initialize method' do

		setup do
			@template_path = File.join Dir.pwd, 'test', 'assets', 'presentation.fodp'
		end

		should "initialize document correctly" do
			obj = OOffice::Base.new File.new @template_path

			assert_instance_of Nokogiri::XML::Document, obj.xml
		end
	end

end




















#

