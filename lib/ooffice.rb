# encoding utf-8

require 'nokogiri'
require 'active_support'
require 'active_support/core_ext/string'

require 'ooffice/base'
require 'ooffice/marker'
require 'ooffice/presentation'

module OOffice

	def instantiate(type, source)
		"#{self}::#{type.to_s.titleize}".constantize.instantiate source
	end

	%w[ Presentation ].each do | type |
		self.instance_eval do
			define_method type do | source |
				self.instantiate type, source
			end
		end
	end

	extend self
end

