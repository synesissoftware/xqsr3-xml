# frozen_string_literal: true

source "https://rubygems.org"

gemspec

# Nokogiri version constraints by Ruby version (override gemspec for older MRI).
unless $Xqsr3_XML_Required_Nokogiri_VersionConditions_

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
    else

      $Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '~> 1.10.1' ]
    end
  else

    unless RUBY_VERSION_parts_[0] >= 3

      raise "Invalid Ruby version: " + RUBY_VERSION
    end

    # leave $Xqsr3_XML_Required_Nokogiri_VersionConditions_ as nil
    # so an unconstrained modern nokogiri is selected
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
