@ECHO OFF

REM ########################################################################
REM File:     build_gem.cmd
REM
REM Purpose:  Builds the gem
REM
REM Created:  11th July 2016
REM Updated:  14th August 2026
REM
REM ########################################################################

FOR %%f IN (*.gemspec) DO gem build "%%f" %*
