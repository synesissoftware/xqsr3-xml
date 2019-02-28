#!/bin/bash

# ######################################################################## #
# File:         test_unit.sh
#
# Purpose:      Executes the unit-tests regardless of calling directory
#
# Created:      9th June 2011
# Updated:      14th March 2018
#
# Author:       Matthew Wilson
#
# Copyright (c) Matthew Wilson, 2011
# All rights reserved
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# * Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
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

Source="${BASH_SOURCE[0]}"

while [ -h "$Source" ]; do

  Dir="$(cd -P "$(dirname "$Source")" && pwd)"
  Source="$(readlink "$Source")"
  [[ $Source != /* ]] && Source="$Dir/$Source"
done
Dir="$(cd -P "$( dirname "$Source" )" && pwd)"

Separate=
DebugFlag=

for v in "$@"
do

	case "$v" in

		--debug)

			DebugFlag=--debug

			;;

		--help)

			echo "USAGE: $Source { | --help | [ --debug ] [ --separate ] }"
			echo
			echo "flags:"
			echo
			echo "	--help"
			echo "		shows this help and terminates"
			echo
			echo "	--debug"
			echo "		executes Ruby interpreter in debug mode"
			echo
			echo "	--separate"
			echo "		executes each unit-test in a separate program"
			echo

			exit
			;;

		--separate)

			Separate=true

			;;

		*)

			echo "unrecognised argument; use --help for usage"

			exit 1
			;;
	esac
done

if [ -z "$Separate" ]; then

	ruby $DebugFlag $Dir/test/unit/ts_all.rb
else

	find $Dir -name 'tc_*.rb' -exec ruby $DebugFlag {} \;
fi

# ############################## end of file ############################# #


