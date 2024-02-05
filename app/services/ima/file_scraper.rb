module Ima
  class FileScraper
    require 'mechanize'

    def initialize(url, file_type)
      @url = url
      @file_type = file_type
    end

    def call
      client = Mechanize.new
      page = client.get(@url)
      page.links.select do |link|
        # addable = link.href.include?('https://myimasrm.ima.it/iungo')
        correct_type = link.href.include?(@file_type)
        splitted_count = link.href.split('_').count
        if splitted_count == 4 && correct_type
          string_end = "#{link.href.split('_')[2]}_#{link.href.split('_')[3]}"
          code = string_end.split('.')[0].upcase
        elsif splitted_count == 3 && correct_type
          string_end = link.href.split('_')[2]
          code = string_end.split('.')[0].upcase
        end
        item = Item.find_by(code:)
        item.update("#{@file_type}_url": link.href) if item.present?
      end
    end
  end
end
