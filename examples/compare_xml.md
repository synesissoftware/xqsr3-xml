# xqsr3-xml - Example - **compare_xml**

## Summary

Simple example illustrating use of ``xml_compare``.

## Source

```ruby

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
```

Two XML fragments that differ only in attribute order are compared (they
are treated as the same by default). A third fragment with a different
``age`` is then compared, which is reported as different.

## Usage

When run (with ``lib`` on the load path, or after ``gem install xqsr3-xml``), this produces the following output:

```
attribute-order-insensitive: same
age mismatch: different, because: different attributes: lhs-node=<person name="Ada" age="36"/>; rhs-node=<person name="Ada" age="37"/>
```


<!-- ########################### end of file ########################### -->
