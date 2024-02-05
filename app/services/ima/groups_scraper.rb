module Ima
  class GroupsScraper
    require 'watir'
    require 'nokogiri'

    def initialize(url, groups)
      @url = url
      @groups = groups
    end

    def call
      # Create a Watir browser instance with the configured options
      client = Mechanize.new
      page = client.get(@url)
      doc = Nokogiri::HTML(page.body)

      @groups.each do |group|
        target_element = doc.at_css("span:contains('#{group.code}')")
        if target_element
          name = target_element.parent.parent.text.strip
          name.slice! group.code
          group.update(name:)
        else
          puts 'Element not found'
        end
      end
    end
  end
end
