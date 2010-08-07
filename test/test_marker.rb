require 'helper'

class TestMarker < Test::Unit::TestCase

	context 'marker class' do

		setup do
			xml = Nokogiri::XML("<a>some text and __marker__ there</a>")
			@element = xml.css('a').first
			@match_data = OOffice::Base::MARKER_RE.match @element.content
			@marker = OOffice::Marker.new @element, @match_data
		end

		should "calculate replace range correctly" do
			assert_equal (14 ... 24), @marker.replace_range
		end

		should "replace correctly" do
			@marker.replace 'NEW TEXT'
			assert_equal 'some text and NEW TEXT there', @marker.text_node.content
		end

	end

end

