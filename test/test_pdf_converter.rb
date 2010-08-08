require 'helper'

class TestPdfConverter < Test::Unit::TestCase

	context 'convering to pdf' do

		setup do
			@presentation_path = File.join Dir.pwd, 'test/assets/presentation.fodp'
			@presentation = OOffice::Presentation.new IO.read(@presentation_path), 'test_name'
		end

		should "conver to pdf with specified file name" do
#			@presentation.to_pdf 'xxx.pdf'
#			assert File.exists?(File.join(@presentation.class.out_dir, 'xxx.pdf')), 'Pdf file not created'
		end

		should "return out_dir" do
			assert_not_nil OOffice::Presentation.out_dir
		end

		should "change out_dir" do
			old = OOffice::Presentation.out_dir
			OOffice::Presentation.out_dir = '/tmp/new_results'

			assert_equal '/tmp/new_results', OOffice::Presentation.out_dir
			assert_not_equal old, OOffice::Presentation.out_dir
		end

		should "calculate output_file_name with specified document name" do
			@presentation.name = 'some_another_name'
			path = File.join OOffice::Presentation.out_dir, 'some_another_name.pdf'

			assert_equal path, @presentation.calculate_out_file_name(nil)
		end

		should "calculate output_file_name with specified file name" do
			@presentation.name = 'some_another_name'
			path = File.join OOffice::Presentation.out_dir, 'xxx.pdf'

			assert_equal path, @presentation.calculate_out_file_name('xxx.pdf')
		end


	end

end

