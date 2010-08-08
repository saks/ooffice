# encoding utf-8

module OOffice
	class Base

		MARKER_RE = /(__(\S+)__)/

		attr_reader :xml, :source

		delegate :to_xml, :to => :xml
		delegate :to_s,   :to => :xml

		def initialize(source)
			@source = source
			@xml    = parse_xml
		end


		# Parses instance file from instance variable *@file* and returns
		# Nokogiri xml document.
		def parse_xml
			Nokogiri::XML(@source) do | config |
				config.strict.noent.noblanks
			end
		end

	end # end of Base class
end # end of OOffice module

