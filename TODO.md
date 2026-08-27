# xqsr3-xml - TODO <!-- omit in toc -->


## Functional improvements

* [ ] quiet the assigned-but-unused variable warning in **test/unit/xml/utilities/tc_navigation.rb** (`doc`; Ruby 3.4 `-W` / CI **Warnings** job);>


## Performance improvements

* \<none>


## Packaging improvements

* [x] ~~~updated **run_all_unit_tests.sh** (from **misc-dev-scripts**) to skip `tput` when `$TERM` is unset or stdout is not a TTY~~~;
* [x] ~~~**Gemfile** `lockfile false`; stop tracking **Gemfile.lock**; CI `bundler-cache: false`~~~;
* [x] ~~~gemspec polish: README tagline as `spec.summary`, package docs, exclude **Gemfile.lock** / **.ruby-version**~~~;
* [x] ~~~README canonical structure (tagline before badges; **Dependencies**; CI badge → **ruby.yml**)~~~;
* [x] ~~~after the packaging/boilerplate/CI baseline: bump **VERSION** and align **CHANGES**/**NEWS**~~~;


<!-- ########################### end of file ########################### -->
