#! /usr/bin/env ruby

# examples/compare_xml.rb


require 'xqsr3/xml/utilities/compare'


include Xqsr3::XML::Utilities::Compare


lhs = '<person name="Ada" age="36"/>'
rhs_same = '<person age="36" name="Ada"/>'
rhs_diff = '<person name="Ada" age="37"/>'

r_same = xml_compare(lhs, rhs_same)
r_diff = xml_compare(lhs, rhs_diff)

puts "attribute-order-insensitive: #{r_same}"
puts "age mismatch: #{r_diff}"
