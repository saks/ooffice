require 'helper'

class TestPresentation < Test::Unit::TestCase

	context 'instantizte method' do
		setup do
			@presentation_path = File.join Dir.pwd, 'test/assets/presentation.fodp'
		end

		should "find all of the marked elements" do
			presentation = OOffice::Presentation IO.read @presentation_path

			assert_equal 6, presentation.markers.size

			# name, marked, xxx, second_page, parent, module
		end
	end

end

