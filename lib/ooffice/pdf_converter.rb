# encoding: utf-8

module OOffice

	module PdfConverter

		def self.included(base)
			base.send :extend, ClassMethods
		end

		def to_pdf(output_file_name=nil)
			input_file = Tempfile.new 'xmltemplate'
			input_file.puts self.to_xml
			output_file_name = calculate_out_file_name output_file_name

			# system("xvfb-run -a unoconv -f pdf #{input_file.path}")
			system("xvfb-run -a unoconv -f pdf --stdout #{input_file.path} > #{output_file_name}")

			input_file.close
			input_file.unlink
		end

		def calculate_out_file_name(output_file_name)
			output_file_name = self.name + '.pdf' unless output_file_name
			File.join ClassMethods::out_dir, output_file_name
		end

		module ClassMethods
			@@out_dir = '/tmp/result'

			FileUtils.rm_r    @@out_dir
			FileUtils.mkdir_p @@out_dir

			def out_dir=(new_out_dir) @@out_dir = new_out_dir end
			def out_dir()             @@out_dir               end

			extend self
		end

	end

end

