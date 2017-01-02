module SvuEbooks
  class RottenTomatoesPlotFetcher < PlotFetcher

    SEASONS = (1..18)

    def self.source
      "Rotten Tomatoes"
    end

    def url
      formatted_season = season < 10 ? "0#{season}" : season
      "https://www.rottentomatoes.com/tv/law-and-order-special-victims-unit/s#{formatted_season}"
    end

    def connect_to_source
      Nokogiri::HTML(open(url))
    end

    def filter_episodes(response)
      response.css('.synopsis').map do |episode|
        episode.children.first.text.strip
      end
    end
  end
end
