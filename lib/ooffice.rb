# encoding utf-8

require 'tempfile'

require 'nokogiri'
require 'active_support'
require 'active_support/core_ext/string'
require 'active_support/basic_object'

require 'ooffice/pdf_converter'
require 'ooffice/base'
require 'ooffice/marker'
require 'ooffice/data_table'
require 'ooffice/presentation'

module OOffice

	def instantiate(type, source, name)
		"#{self}::#{type.to_s.titleize}".constantize.instantiate source, name
	end

	%w[ Presentation ].each do | type |
		self.instance_eval do
			define_method type do | source, name=nil | #TODO: port to ruby 1.8.6
				self.instantiate type, source, (name or "template_#{rand}")
			end
		end
	end

	extend self
end

