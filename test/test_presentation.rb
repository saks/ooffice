require 'helper'

class TestPresentation < Test::Unit::TestCase

	UNIQ_MARKERS_NUMBER = 7

	context 'instance methods' do
		setup do
			@presentation_path = File.join Dir.pwd, 'test/assets/presentation.fodp'
			@presentation = OOffice::Presentation.new IO.read(@presentation_path), 'test_name'
		end

		should "find all of the marked elements" do
			assert_equal UNIQ_MARKERS_NUMBER, @presentation.markers.size
		end

		should "assign setter methods" do
			methods_before = @presentation.methods.size
			@presentation.assign_setter_merthods

			assert_equal methods_before + UNIQ_MARKERS_NUMBER, @presentation.methods.size
		end

		should "find table" do
			tables = @presentation.tables.instance_variable_get :@tables
			assert_equal 1, tables.size
			sex_and_age_table = tables['sex_and_age']
			assert_not_nil sex_and_age_table
			assert_equal 4, sex_and_age_table.rows.size
			assert_equal 2, sex_and_age_table.rows.first.cells.size
		end

		should "replace text with setter methods" do
			@presentation = OOffice::Presentation IO.read(@presentation_path)

			@presentation.module = 'my favourite module'
			@presentation.parent = 'parent from ruby 1.9.1'
			@presentation.url    = 'mernik.by'
			@presentation.marker = '"there was a marker"'
			@presentation.xxx    = '<something sensored>'
			@presentation.second_page = 'SECOND PAGE'

			@presentation.tables.sex_and_age :rows => [ [9, 10], [8, 9], [7, 8], [6, 7] ]

			result = @presentation.xml.to_s

			assert_no_match /__module__/,      result
			assert_no_match /__parent__/,      result
			assert_no_match /__url__/,         result
			assert_no_match /__second_page__/, result
			assert_no_match /__xxx__/,         result
			assert_no_match /__marker__/,      result
		end

		should "should raise error if marker name the same as accessor method" do
			@presentation.instance_variable_set :@markers, {'name' => 'something'}

			assert_raise(OOffice::Marker::ForbiddenMarkerName) { @presentation.assign_setter_merthods }
		end

	end



























end

