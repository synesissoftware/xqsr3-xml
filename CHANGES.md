# xqsr3-xml - Changes <!-- omit in toc -->


## 0.1.4 - 28th August 2026

* removed an unused local variable from the navigation unit test so the warning-enabled test run is clean;
* **.github/workflows/ruby.yml**: replaced the obsolete **bp-2** push branch with **warnings** and updated its revision date;
* **xqsr3-xml.gemspec**: centralised project URLs and updated source-code metadata to avoid a duplicate-URI warning when building the gem;
* updated the library version to **0.1.4**;


## 0.1.3 - 19th August 2026

* converted **lib/** and **test/** Ruby sources from tab indent to 2-space indent;
* **Gemfile**: Nokogiri pins follow the last-supported series per MRI (including **2.6**, **2.7**, **3.0**, **3.1**) so `bundle install` resolves on current platforms;
* **xqsr3-xml.gemspec**: `spec.summary` matches the README tagline; packaged **AUTHORS**, **CHANGES**, **CONTRIBUTING**, **EXAMPLES**, **FAQ**, **INSTALL**, **NEWS**, **SECURITY**, and **TODO**; **Gemfile.lock** and **.ruby-version** excluded from `spec.files`;
* stop tracking **Gemfile.lock**; **Gemfile** sets `lockfile false` when Bundler supports it; CI uses `bundler-cache: false` because Bundler 4 then writes no lockfile and **ruby/setup-ruby** cache cats **Gemfile.lock**;
* CI **Warnings** job now runs on Ruby **3.4**;
* updated **run_all_unit_tests.sh** (from https://github.com/synesissoftware/misc-dev-scripts) to skip **tput** when **$TERM** is unset or stdout is not a TTY;
* reordered **README.md** (tagline before badges; TOC after badges), added Language / License / Last Commit badges and **Dependencies** (Efferent / Afferent);
* added **examples/compare_xml** and catalogued it in **EXAMPLES.md**;


## 0.1.2 - 15th August 2026

* added `# frozen_string_literal: true` to all **lib/** sources;


## 0.1.1 - 11th April 2019

* project boilerplate;
* version adjustment;
* added **Gemfile** with Ruby-version-discriminated **Nokogiri** dependencies;
* added **.ruby-version-exclusions**;
* updated **run_all_unit_tests.sh** (from **misc-dev-scripts**);


## 0.1.0.1 - 2nd March 2019

* build-number update for packaging;


## 0.1.0 - 1st March 2019

* first public release;


<!-- ########################### end of file ########################### -->
