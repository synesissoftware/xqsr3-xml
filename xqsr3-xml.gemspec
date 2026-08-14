# ######################################################################## #
# File:     xqsr3-xml.gemspec
#
# Purpose:  Gemspec for xqsr3-xml library
#
# Created:  1st March 2019
# Updated:  15th August 2026
#
# ######################################################################## #


$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'xqsr3/xml/version'


Gem::Specification.new do |spec|

  spec.name         = 'xqsr3-xml'
  spec.version      = Xqsr3::XML::VERSION
  spec.summary      = 'xqsr3-xml'
  spec.description  = <<END_DESC
xqsr3 - eXtensions by fine Quantum for Standard Ruby and 3rd-party libraries
- is a lightweight, low-coupling library of assorted extensions to standard
ruby and 3rd-party libraries.

xqsr3-xml contains the XML-related components for xqsr3, so that the core
library remains independent of any non-standard libraries.
END_DESC

  spec.authors      = [
    'Matt Wilson',
  ]
  spec.email        = [
    'matthew@synesis.com.au',
  ]
  spec.homepage     = 'https://github.com/synesissoftware/xqsr3-xml'
  spec.license      = 'BSD-3-Clause'

  spec.required_ruby_version = [ '>= 2.0' ]

  spec.files        = Dir[ 'Rakefile', '{bin,examples,lib,man,spec,test}/**/*', 'README*', 'LICENSE*' ] & `git ls-files -z`.split("\0")

  spec.add_runtime_dependency "xqsr3", [ '>= 0.39.5', '< 1.0' ]
  spec.add_runtime_dependency "nokogiri", [ '~> 1.6' ]
end


# ############################## end of file ############################# #
