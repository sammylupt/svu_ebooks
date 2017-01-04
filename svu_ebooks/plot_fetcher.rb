module SvuEbooks
  class PlotFetcher
    class NotImplementedError < StandardError; end

    attr_reader :season

    def initialize(season)
      @season = season
    end

    def gather!
      begin
        start_time = Time.now
        start_logging

        response = connect_to_source

        filter_episodes(response).tap { finish_logging(start_time) }
      rescue => e
        puts "Error!"
        puts e
      end
    end

    def source
      self.class.source
    end

    private

    def start_logging
      puts "Fetching #{source} descriptions for season #{season}"
    end

    def finish_logging(start_time)
      time_elapsed = (Time.now - start_time).round(2)
      puts "Finished #{source} descriptions for season #{season} in #{time_elapsed} seconds"
    end

    def self.source
      throw NotImplementedError
    end

    def connect_to_source
      throw NotImplementedError
    end

    def filter_episodes(content)
      throw NotImplementedError
    end
  end
end
