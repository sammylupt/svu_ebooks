module SvuEbooks
  class HuluPlotFetcher < PlotFetcher

    SEASONS = (1..22)
    TOKEN = ENV["hulu_auth_token"]

    def self.source
      "Hulu"
    end

    def connect_to_source
      url = "http://mozart.hulu.com/v1.h2o/shows/389/episodes?season_number=#{season}&show_id=389&video_type=episode&items_per_page=32&_device_id=1&region=us&locale=en&language=en&access_token=#{TOKEN}"
      JSON.parse(open(url).read)
    end

    def filter_episodes(response)
      response["data"].map do |episode|
        episode["video"]["description"]
      end
    end
  end
end
