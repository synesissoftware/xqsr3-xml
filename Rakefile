# frozen_string_literal: true

# Rakefile for xqsr3-xml

require 'rake/testtask'


Rake::TestTask.new do |tt|

  tt.libs << 'lib'
  tt.libs << 'test'
  tt.name = 'test'
  tt.test_files = FileList['test/**/tc_*.rb']
  tt.verbose = true
end


task :default => :test


# ############################## end of file ############################# #
