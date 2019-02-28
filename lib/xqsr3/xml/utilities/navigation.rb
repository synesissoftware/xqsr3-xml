
# ######################################################################## #
# File:         lib/xqsr3/xml/_utilities/navigation.rb
#
# Purpose:      Definition of the ::Xqsr3::XML::Utilities::Navigation
#               module
#
# Created:      7th August 2018
# Updated:      7th August 2018
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matthew Wilson
#
# Copyright (c) 2018, Matthew Wilson and Synesis Software
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
# ::Xqsr3::XML::Utilities::Navigation

=begin
=end

require 'xqsr3/quality/parameter_checking'

require 'nokogiri'

module Xqsr3
module XML
module Utilities

module Navigation

	module Internal_Compare_

		extend ::Xqsr3::Quality::ParameterChecking

		def self.get_descendants node

			descendants	=	[]

			node.children.each do |child|

				descendants	<<	child

				descendants	+=	self.get_descendants child
			end

			descendants
		end
	end # module Internal_Compare_

	def self.included receiver

		def receiver.get_descendants node

			Internal_Compare_.get_descendants node
		end
	end

	def self.get_descendants node

		Internal_Compare_.get_descendants node
	end

	def get_descendants

		Internal_Compare_.get_descendants self
	end
end # module Navigation

end # module Utilities
end # module XML
end # module Xqsr3

# ############################## end of file ############################# #


