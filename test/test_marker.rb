require 'helper'

class TestMarker < Test::Unit::TestCase

	context 'marker class' do

		setup do
			xml = Nokogiri::XML("<a>some text and __marker__ there</a>")
			@text_node  = xml.css('a').first.child
			@match_data = @text_node.content.scan(OOffice::Base::MARKER_RE)[0]
			@marker = OOffice::Marker.new @text_node, @match_data[0]
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

