
# ######################################################################## #
# File:         lib/xqsr3/xml/_utilities/compare.rb
#
# Purpose:      Definition of the ::Xqsr3::XML::Utilities::Compare
#               module
#
# Created:      30th July 2017
# Updated:      16th August 2018
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matthew Wilson
#
# Copyright (c) 2017-2018, Matthew Wilson and Synesis Software
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
#
# * Neither the names of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ######################################################################## #


# ##########################################################
# ::Xqsr3::XML::Utilities::Compare

=begin
=end

require 'xqsr3/xml/utilities/navigation'

require 'xqsr3/quality/parameter_checking'

require 'nokogiri'

module Xqsr3
module XML
module Utilities

module Compare

	# Class that represents the result of an XML comparison
	#
	# NOTE: Sadly, we cannot create instances of +FalseClass+/+TrueClass+,
	# to which we could then add a +reason+ attribute, so instead we must
	# have a results class
	class Result

		include ::Xqsr3::Quality::ParameterChecking

		protected :check_parameter

		#
		# Options:
		#
		# +:different_attributes+
		# +:different_attribute_count+
		# +:different_attribute_order+
		# +:different_child_node_count+
		# +:different_child_node_order+
		# +:different_child_nodes+
		# +:different_node_names+
		# +:different_node_contents+
		# +:parameter_is_empty+
		# +:parameter_is_nil+
		# +:+

		def initialize status, reason, **options

			@call_stack	=	caller(2)

			check_parameter status, 'status', types: [ ::FalseClass, ::TrueClass ]
			check_parameter reason, 'reason', type: ::Symbol, allow_nil: true

			@status		=	status
			@reason		=	reason

			@lhs_node	=	options[:lhs_node]
			@rhs_node	=	options[:rhs_node]
		end

		def self.return status, reason, **options

			return self.new status, reason, **options
		end

		def self.same reason = nil, **options

			return self.new true, reason, **options
		end

		def self.different reason, **options

			return self.new false, reason, **options
		end

		attr_reader :call_stack
		attr_reader :status
		attr_reader :reason

		def different?

			!status
		end

		def same?

			status
		end

		def details

			r	=	reason.to_s.gsub(/_/, ' ')

			qualifying	=	''

			if @lhs_node

				qualifying	+=	'; ' unless qualifying.empty?
				qualifying	+=	"lhs-node=#{@lhs_node}"
			end

			if @rhs_node

				qualifying	+=	'; ' unless qualifying.empty?
				qualifying	+=	"rhs-node=#{@rhs_node}"
			end

			r = "#{r}: #{qualifying}" unless qualifying.empty?

			r
		end

		def to_s

			return 'same' if same?

			"different, because: #{details}"
		end
	end

	module Internal_Compare_

		include ::Xqsr3::XML::Utilities::Navigation

		extend ::Xqsr3::Quality::ParameterChecking

		DEFAULT_OPTIONS = {

			debug: false,
#			element_order: false,
			equate_nil_and_empty: false,
			ignore_attributes: false,
			ignore_attribute_order: true,
			ignore_child_node_order: true,
			ignore_content: false,
			ignore_content_case: false,
			ignore_xml_declarations: true,
			normalise_whitespace: true,
#			normalize_whitespace: true,
			validate_params: true,
		}

		ORDER_OPTIONS_SYMBOLS = [

			:element_order,
			:ignore_attribute_order,
			:ignore_child_node_order,
			:ignore_content,
			:ignore_content_case,
		]

		WHITESPACE_OPTIONS_SYMBOLS = [

			:normalise_whitespace,
			:normalize_whitespace,
		]

		def self.derive_options_ given_options

			default_options	=	DEFAULT_OPTIONS
			derived_options	=	{}.merge given_options


			# sort whitespace

			if WHITESPACE_OPTIONS_SYMBOLS.any? { |sym| given_options.has_key? sym }

				default_options	=	default_options.reject { |k, v| WHITESPACE_OPTIONS_SYMBOLS.include? k }
			end

			if given_options.has_key? :normalise_whitespace

				derived_options.delete :normalize_whitespace
			elsif given_options.has_key? :normalize_whitespace

				derived_options[:normalise_whitespace] = given_options[:normalize_whitespace]

				derived_options.delete :normalize_whitespace
			end


			# sort element-order

			if ORDER_OPTIONS_SYMBOLS.any? { |sym| given_options.has_key? sym }

				default_options	=	default_options.reject { |k, v| ORDER_OPTIONS_SYMBOLS.include? k }
			end

			if given_options.has_key? :element_order

				element_order	=	given_options[:element_order]

				derived_options[:ignore_attribute_order]	=	!element_order
				derived_options[:ignore_child_node_order]	=	!element_order
			end

			derived_options[:ignore_attribute_order]	=	given_options[:ignore_attribute_order] if given_options.has_key? :ignore_attribute_order
			derived_options[:ignore_child_node_order]	=	given_options[:ignore_child_node_order] if given_options.has_key? :ignore_child_node_order

			default_options.merge derived_options
		end

		def self.one_line_ s

			s = s.to_s.gsub(/\s+/, ' ')
		end

		#
		# +:debug+
		# +:element_order+
		# +:equate_nil_and_empty+
		# +:ignore_attributes+
		# +:ignore_attribute_order+
		# +:ignore_xml_declarations+
		# +:normalise_whitespace+
		# +:normalize_whitespace+
		# +:validate_params+
		#

		def self.xml_compare_ lhs, rhs, options

			$stderr.puts "#{self}#{__method__}(lhs (#{lhs.class})=#{self.one_line_ lhs}, rhs (#{rhs.class})=#{self.one_line_ rhs}, options (#{options.class})=#{options})" if $DEBUG

			# validate parameter(s)

			check_parameter options, 'options', type: ::Hash if $DEBUG

			validate_params	=	$DEBUG || options[:debug] || options[:validate_params]

			check_parameter lhs, 'lhs', types: [ ::String, ::Nokogiri::XML::Node ], allow_nil: true if validate_params
			check_parameter rhs, 'rhs', types: [ ::String, ::Nokogiri::XML::Node ], allow_nil: true if validate_params

			options			=	self.derive_options_ options

			# deal with nil(s)

			return Result.same if lhs.nil? && rhs.nil?

			if lhs.nil?

				return Result.same if options[:equate_nil_and_empty] && ::String === rhs && rhs.empty?

				return Result.different :parameter_is_nil
			end

			if rhs.nil?

				return Result.same if options[:equate_nil_and_empty] && ::String === lhs && lhs.empty?

				return Result.different :parameter_is_nil
			end


			# deal with string(s)

			lhs	=	Nokogiri::XML(lhs) if ::String === lhs
			rhs	=	Nokogiri::XML(rhs) if ::String === rhs



			# deal with XML Declaration(s)

			if options[:ignore_xml_declarations]

				if ::Nokogiri::XML::Document === lhs

					lhs_root	=	lhs.root
					lhs			=	lhs_root if lhs_root
				end

				if ::Nokogiri::XML::Document === rhs

					rhs_root	=	rhs.root
					rhs			=	rhs_root if rhs_root
				end
			end


			self.xml_compare_nodes_ lhs, rhs, options
		end

		def self.xml_compare_nodes_ lhs, rhs, options

			$stderr.puts "#{self}#{__method__}(lhs (#{lhs.class})=#{self.one_line_ lhs}, rhs (#{rhs.class})=#{self.one_line_ rhs}, options (#{options.class})=#{options})" if $DEBUG


			# Compare:
			#
			# - name
			# - attributes
			# - content
			# - children
			# - 


			# ##########################
			# name

			lhs_name	=	lhs.name
			rhs_name	=	rhs.name

			return Result.different :different_node_names, lhs_node: lhs, rhs_node: rhs if lhs_name != rhs_name


			# ##########################
			# attributes

			unless options[:ignore_attributes]

				lhs_attributes	=	lhs.attribute_nodes
				rhs_attributes	=	rhs.attribute_nodes

				return Result.different :different_attribute_count, lhs_node: lhs, rhs_node: rhs if lhs_attributes.count != rhs_attributes.count


				lhs_attr_list	=	lhs_attributes.map { |attr| [ attr.name, attr.content ] }
				rhs_attr_list	=	rhs_attributes.map { |attr| [ attr.name, attr.content ] }

				if lhs_attr_list != rhs_attr_list

					# do the sort first

					lhs_attr_list.sort! { |l, r| l[0] <=> r[0] }
					rhs_attr_list.sort! { |l, r| l[0] <=> r[0] }

					# Now there are four possibiliies:
					#
					# 1. Different attributes
					# 2. Different attribute order
					# 3. Same (when reordered)

					if lhs_attr_list == rhs_attr_list

						if options[:ignore_attribute_order]

							# 3
						else

							# 2

							return Result.different :different_attribute_order, lhs_node: lhs, rhs_node: rhs
						end
					else

						return Result.different :different_attributes, lhs_node: lhs, rhs_node: rhs
					end
				end
			end

			# ##########################
			# content

			unless options[:ignore_content]

				lhs_texts		=	self.get_descendants(lhs).select { |el| el.text? }.map { |el| el.content }
				rhs_texts		=	self.get_descendants(rhs).select { |el| el.text? }.map { |el| el.content }

				content_same	=	lhs_texts == rhs_texts

				unless content_same

					if options[:normalise_whitespace]

						lhs_texts		=	lhs_texts.reject { |s| s.strip.empty? }
						rhs_texts		=	rhs_texts.reject { |s| s.strip.empty? }

						content_same	=	lhs_texts == rhs_texts
					end
				end

				unless content_same

					if options[:ignore_content_case]

						lhs_texts		=	lhs_texts.reject { |s| s.downcase }
						rhs_texts		=	rhs_texts.reject { |s| s.downcase }

						content_same	=	lhs_texts == rhs_texts
					end
				end

				unless content_same

					if options[:ignore_child_node_order]

						lhs_texts		=	lhs_texts.sort
						rhs_texts		=	rhs_texts.sort

						content_same	=	lhs_texts == rhs_texts
					end
				end

				return Result.different :different_node_contents, lhs_node: lhs, rhs_node: rhs unless content_same
			end


			# ##########################
			# children (preparation)

			lhs_children		=	lhs.children.to_a
			rhs_children		=	rhs.children.to_a

			lhs_children.reject! { |child| child.text? && child.content.strip.empty? }
			rhs_children.reject! { |child| child.text? && child.content.strip.empty? }


			# ##########################
			# children - count

			lhs_children_count	=	lhs_children.count
			rhs_children_count	=	rhs_children.count

			return Result.different :different_child_node_count, lhs_node: lhs, rhs_node: rhs if lhs_children_count != rhs_children_count


			# ##########################
			# children - names

			lhs_children_names	=	lhs_children.map { |ch| ch.name }
			rhs_children_names	=	rhs_children.map { |ch| ch.name }

			if lhs_children_names != rhs_children_names

				# At this point, the lists of names of child elements are
				# different. This may be because there are different
				# elements or because they are in a different order. Either
				# way, in order to provide detailed reasons for
				# inequivalency, we must do an order-independent comparison

				children_sorted_lhs	=	lhs_children.sort { |x, y| x.name <=> y.name }
				children_sorted_rhs	=	rhs_children.sort { |x, y| x.name <=> y.name }

				ch_names_sorted_lhs	=	children_sorted_lhs.map { |ch| ch.name }
				ch_names_sorted_rhs	=	children_sorted_rhs.map { |ch| ch.name }

				ignore_order		=	options[:ignore_child_node_order]

				if ignore_order

					return Result.different :different_child_nodes, lhs_node: lhs, rhs_node: rhs if ch_names_sorted_lhs != ch_names_sorted_rhs

					# Since they are the same (when reordered), we need to
					# adopt the ordered sequences so that the comparison of
					# the children are meaningful

					lhs_children	=	children_sorted_lhs
					rhs_children	=	children_sorted_rhs
				else

					# failed, so need to determine whether it's due to
					# different nodes or different order

					if ch_names_sorted_lhs == ch_names_sorted_rhs

						return Result.different :different_child_node_order, lhs_node: lhs, rhs_node: rhs
					else

						return Result.different :different_child_nodes, lhs_node: lhs, rhs_node: rhs
					end
				end
			end

			(0 ... lhs_children.count).each do |index|

				ch_lhs	=	lhs_children[index]
				ch_rhs	=	rhs_children[index]

				r = self.xml_compare_nodes_ ch_lhs, ch_rhs, options

				return r unless r.status
			end

			return Result.same
		end
	end

	def self.xml_compare lhs, rhs, **options

		$stderr.puts "#{self}#{__method__}(lhs (#{lhs.class})=#{Internal_Compare_.one_line_ lhs}, rhs (#{rhs.class})=#{Internal_Compare_.one_line_ rhs}, options (#{options.class})=#{options})" if $DEBUG

		Internal_Compare_.xml_compare_ lhs, rhs, options
	end

	def xml_compare lhs, rhs, **options

		$stderr.puts "#{self}#{__method__}(lhs (#{lhs.class})=#{Internal_Compare_.one_line_ lhs}, rhs (#{rhs.class})=#{Internal_Compare_.one_line_ rhs}, options (#{options.class})=#{options})" if $DEBUG

		Internal_Compare_.xml_compare_ lhs, rhs, options
	end

end # module Compare

end # module Utilities
end # module XML
end # module Xqsr3

# ############################## end of file ############################# #


