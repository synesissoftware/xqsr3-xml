#! /usr/bin/env ruby
#
# executes all other tests

this_dir    =   File.expand_path(File.dirname(__FILE__))

# all tc_*rb in current directory
Dir[File.join(this_dir, 'tc_*rb')].each { |file| require file }

# all ts_*rb in immediate sub-directories
Dir[File.join(this_dir, '*', 'ts_*rb')].each { |file| require file }

