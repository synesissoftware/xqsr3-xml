# ######################################################################## #
# File:     xqsr3-xml.gemspec
#
# Purpose:  Gemspec for xqsr3-xml library
#
# Created:  1st March 2019
# Updated:  19th August 2026
#
# ######################################################################## #


$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'xqsr3/xml/version'


Gem::Specification.new do |spec|

  spec.name         = 'xqsr3-xml'
  spec.summary      = 'eXtensions by fine Quantum for Standard Ruby and 3rd-party libraries, for XML'
  spec.version      = Xqsr3::XML::VERSION
  spec.description  = <<END_DESC
eXtensions by fine Quantum for Standard Ruby and 3rd-party libraries, for
XML. xqsr3-xml contains the XML-related components formerly in xqsr3, so
that the core library remains independent of any non-standard libraries.
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

  spec.add_runtime_dependency "nokogiri", [ '~> 1.6' ]
  spec.add_runtime_dependency "xqsr3", [ '>= 0.39.5', '< 1.0' ]

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/synesissoftware/xqsr3-xml/issues',
    'changelog_uri' => 'https://github.com/synesissoftware/xqsr3-xml/blob/master/CHANGES.md',
    'homepage_uri' => 'https://github.com/synesissoftware/xqsr3-xml',
    'source_code_uri' => 'https://github.com/synesissoftware/xqsr3-xml',
  }

  spec.files = Dir[
    'Rakefile',
    '{bin,examples,lib,man,spec,test}/**/*',
    'AUTHORS*',
    'CHANGES*',
    'CONTRIBUTING*',
    'EXAMPLES*',
    'FAQ*',
    'INSTALL*',
    'LICENSE*',
    'NEWS*',
    'README*',
    'SECURITY*',
    'TODO*',
  ] & `git ls-files -z`.split("\0")
  spec.files -= [
    '.ruby-version',
    'Gemfile.lock',
  ]
end


# ############################## end of file ############################# #
