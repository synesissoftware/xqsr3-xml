# xqsr3-xml <!-- omit in toc -->

e**X**tensions by fine **Q**uantum for **S**tandard **R**uby and **3**rd-party libraries, for **XML**

![Language](https://img.shields.io/badge/Ruby-CC342D?style=flat&logo=ruby&logoColor=white)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Gem Version](https://badge.fury.io/rb/xqsr3-xml.svg)](https://badge.fury.io/rb/xqsr3-xml)
[![Last Commit](https://img.shields.io/github/last-commit/synesissoftware/xqsr3-xml)](https://github.com/synesissoftware/xqsr3-xml/commits/master)
[![Ruby](https://github.com/synesissoftware/xqsr3-xml/actions/workflows/ruby.yml/badge.svg)](https://github.com/synesissoftware/xqsr3-xml/actions/workflows/ruby.yml)


## Table of Contents <!-- omit in toc -->

- [Introduction](#introduction)
- [Installation](#installation)
- [Components](#components)
- [Examples](#examples)
- [Project Information](#project-information)
  - [Where to get help](#where-to-get-help)
  - [Contribution guidelines](#contribution-guidelines)
  - [Dependencies](#dependencies)
    - [Efferent (fan-out)](#efferent-fan-out)
      - [Runtime Dependencies (aka "Normal Dependencies")](#runtime-dependencies-aka-normal-dependencies)
      - [Development Dependencies](#development-dependencies)
    - [Afferent (fan-in)](#afferent-fan-in)
      - [Runtime dependents](#runtime-dependents)
      - [Development dependents](#development-dependents)
  - [Related projects](#related-projects)
  - [License](#license)


## Introduction

**xqsr3-xml** provides the XML utilities formerly shipped in [**xqsr3**](https://github.com/synesissoftware/xqsr3/). As of **xqsr3** **0.31**, those components live here so that core **xqsr3** stays independent of any non-standard libraries.

It depends on **Nokogiri** (and **xqsr3**).


## Installation

Install via **gem** as in:

```
gem install xqsr3-xml
```

or add it to your `Gemfile`.

Use is via specific APIs. For example, in order to compare XML you would ``require`` the source file, as in:

```Ruby
require 'xqsr3/xml/utilities/compare'
```


## Components

**xqsr3-xml** provides components in the following category:

* XML Utilities — `Xqsr3::XML::Utilities::Compare` (`xml_compare`) and `Xqsr3::XML::Utilities::Navigation` (`get_descendants`);


## Examples

Examples are provided in the ```examples``` directory, along with a markdown description for each. A detailed list TOC of them is provided in [EXAMPLES.md](./EXAMPLES.md).


## Project Information


### Where to get help

[GitHub Page](https://github.com/synesissoftware/xqsr3-xml "GitHub Page")


### Contribution guidelines

Defect reports, feature requests, and pull requests are welcome on https://github.com/synesissoftware/xqsr3-xml.


### Dependencies


#### Efferent (fan-out)

Libraries upon which **xqsr3-xml** depends:


##### Runtime Dependencies (aka "Normal Dependencies")

* [**Nokogiri**](https://github.com/sparklemotion/nokogiri);
* [**xqsr3**](https://github.com/synesissoftware/xqsr3);


##### Development Dependencies

* [**rake**](https://rubygems.org/gems/rake);
* [**test-unit**](https://rubygems.org/gems/test-unit);


#### Afferent (fan-in)

Projects that depend on **xqsr3-xml**:


##### Runtime dependents

* \<none>;


##### Development dependents

* \<none>;


### Related projects

* [**xqsr3**](https://github.com/synesissoftware/xqsr3/) — core library from which these XML components were split;


### License

**xqsr3-xml** is released under the 3-clause BSD license. See [LICENSE](./LICENSE) for details.


<!-- ########################### end of file ########################### -->
