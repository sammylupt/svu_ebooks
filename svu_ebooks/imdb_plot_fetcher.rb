module SvuEbooks
  class IMDBPlotFetcher < PlotFetcher

    SEASONS = (1..22)

    def self.source
      "IMDb"
    end

    def connect_to_source
      url = "http://www.imdb.com/title/tt0203259/episodes?season=#{season}"
      Nokogiri::HTML(open(url))
    end

    def filter_episodes(response)
      response.css('.item_description').map do |episode|
        episode.children.text.strip
      end
    end
  end
end
