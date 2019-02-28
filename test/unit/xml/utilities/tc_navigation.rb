#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')

require 'xqsr3/xml/utilities/navigation'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

require 'nokogiri'

class Test_Xqsr3_XML_Utilities_Navigation < Test::Unit::TestCase

	include ::Xqsr3::XML::Utilities::Navigation

	def test_get_descendants_1

		xml_s	=	<<END_OF_rhs_doc
<?xml version="1.0"?>
<document>
 <outer>
  <mid_2>
   <inner>some more text</inner>
  </mid_2>
  <mid_1>
   <inner>some text</inner>
  </mid_1>
 </outer>
</document>
END_OF_rhs_doc

		xml		=	::Nokogiri.XML(xml_s)
		doc		=	xml.children.first

		descs	=	self.class.get_descendants xml.children.first

		assert_not_nil descs
		assert_kind_of ::Array, descs

		assert_operator 7, :<=, descs.size
		%w{ outer mid_1 mid_2 }.each do |name|

			assert(descs.find { |el| name == el.name }, "did not find an element named '#{name}' in the collection #{descs}")
		end

		texts	=	descs.select { |el| el.text? }

		[ 'some text', 'some more text' ].each do |text|

			assert(texts.find { |el| text == el.text }, "did not find an element with the text '#{text}' in the collection #{texts}")
		end
	end
end


