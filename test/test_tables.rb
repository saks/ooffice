require 'helper'

class TestTables < Test::Unit::TestCase

	class FakeTable
		def replace(with)
			return with
		end
	end

	context 'tables class' do

		setup do
			@tables = OOffice::Presentation::Tables.new
		end

		should "raise NoMethodError for unknown table name" do
			assert_raise(ArgumentError) { @tables.not_exist }
		end

		should "not raise NoMethodError for unknown table name" do
			@tables['exist'] = 'something'
			assert_nothing_raised(ArgumentError) { @tables.exist('XXX') }
		end

	end




















end

