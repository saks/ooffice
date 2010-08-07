require 'helper'

class TestPresentation < Test::Unit::TestCase

	UNIQ_MARKERS_NUMBER = 6

	context 'instance methods' do
		setup do
			@presentation_path = File.join Dir.pwd, 'test/assets/presentation.fodp'
			@presentation = OOffice::Presentation.new IO.read @presentation_path
		end

		should "find all of the marked elements" do
			assert_equal UNIQ_MARKERS_NUMBER, @presentation.markers.size
		end

		should "assign setter methods" do
			methods_before = @presentation.methods.size
			@presentation.assign_setter_merthods

			assert_equal methods_before + UNIQ_MARKERS_NUMBER, @presentation.methods.size
		end

		should "replace text with setter methods" do
			@presentation.assign_setter_merthods

			@presentation.module = 'my favourite module'
			@presentation.parent = 'parent from ruby 1.9.1'
#			puts @presentation.xml
		end

	end

end

