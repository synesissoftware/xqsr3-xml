@ECHO OFF

REM ########################################################################
REM File:     generate_rdoc.cmd
REM
REM Purpose:  Generates documentation
REM
REM Created:  14th August 2026
REM Updated:  14th August 2026
REM
REM ########################################################################

IF EXIST doc RMDIR /S /Q doc
rdoc ^
  -x build_gem.cmd ^
  -x build_gem.sh ^
  -x generate_rdoc.cmd ^
  -x generate_rdoc.sh ^
  -x run_all_unit_tests.sh ^
  -x *.gemspec ^
  -x doc/ ^
  -x gems/ ^
  -x old-gems/ ^
  -x test/performance/ ^
  -x test/scratch/ ^
  -x tc_.*\.rb ^
  -x ts_all.rb ^
  %*
