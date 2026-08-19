# frozen_string_literal: true

source "https://rubygems.org"

# Suppress lockfile on Bundler 4+ (gem: do not pin the graph). No-op on
# Bundler that lacks the DSL (Ruby 2.x CI). Do not combine with
# ruby/setup-ruby `bundler-cache: true` — that action cats Gemfile.lock
# after `bundle lock` and fails when no file is written (Windows 3.2+,
# where setup-ruby installs Bundler ~> 4).
lockfile false if respond_to?(:lockfile)

gemspec

# Nokogiri version constraints by Ruby version (override gemspec for older MRI).
# Each MRI line is pinned to the last Nokogiri series that still supports it.
unless defined?($Xqsr3_XML_Required_Nokogiri_VersionConditions_)

  $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = nil

  RUBY_VERSION_parts_ = RUBY_VERSION.split(".").map { |s| s.to_i }

  case RUBY_VERSION_parts_[0]
  when 1

    case RUBY_VERSION_parts_[1]
    when 8

      $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '~> 1.5.11' ]
    when 9

      $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '~> 1.6.8' ]
    else

      raise "Invalid Ruby version: " + RUBY_VERSION
    end
  when 2

    case RUBY_VERSION_parts_[1]
    when 0

      $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '~> 1.6.8' ]
    when 1

      $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '~> 1.7.2' ]
    when 2

      $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '~> 1.9.1' ]
    when 3, 4

      $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '~> 1.10.1' ]
    when 5

      $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '>= 1.10.1', '< 1.13' ]
    when 6

      $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '>= 1.10.1', '< 1.14' ]
    when 7

      $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '>= 1.10.1', '< 1.16' ]
    else

      raise "Invalid Ruby version: " + RUBY_VERSION
    end
  when 3

    case RUBY_VERSION_parts_[1]
    when 0

      $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '>= 1.6', '< 1.18' ]
    when 1

      $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '>= 1.6', '< 1.19' ]
    else

      # 3.2+: leave nil for unconstrained modern nokogiri
    end
  else

    unless RUBY_VERSION_parts_[0] >= 4

      raise "Invalid Ruby version: " + RUBY_VERSION
    end

    # 4+: leave nil for unconstrained modern nokogiri
  end
end

if $Xqsr3_XML_Required_Nokogiri_VersionConditions_

  gem "nokogiri", *$Xqsr3_XML_Required_Nokogiri_VersionConditions_
end

# rake 13 requires Ruby >= 2.3
if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("2.3")

  gem "rake", '~> 13.0'
else

  gem "rake", '~> 12.3'
end

gem "test-unit", '~> 3.0'
