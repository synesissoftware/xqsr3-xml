
puts "\nGemfile for Ruby #{RUBY_VERSION}\n"

source 'https://rubygems.org'

unless $Xqsr3_XML_Required_Nokogiri_VersionConditions_

	$Xqsr3_XML_Required_Nokogiri_VersionConditions_	=	nil

	RUBY_VERSION_parts_ = RUBY_VERSION.split('.').map { |s| s.to_i }

	case RUBY_VERSION_parts_[0]
	when 1

		case RUBY_VERSION_parts_[1]
		when 8

			$Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '~> 1.5.11' ]
		when 9

			$Xqsr3_XML_Required_Nokogiri_VersionConditions_ = [ '~> 1.6.8' ]
		else

			raise 'Invalid Ruby version: ' + RUBY_VERSION
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

		raise 'Invalid Ruby version: ' + RUBY_VERSION
	end
end



if $Xqsr3_XML_Required_Nokogiri_VersionConditions_

	gem 'nokogiri', *$Xqsr3_XML_Required_Nokogiri_VersionConditions_
else

	gem 'nokogiri'
end

gem 'xqsr3', '~> 0.31'

