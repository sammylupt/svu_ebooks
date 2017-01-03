module SvuEbooks
  class Populator

    NBC_REGEX = /-- \(C\) NBC/
    INVALID_DESCRIPTION = "Know what this is about?\n Be the first one to add a plot."

    def run!
      klasses = [
        SvuEbooks::IMDBPlotFetcher,
        SvuEbooks::RottenTomatoesPlotFetcher,
        SvuEbooks::HuluPlotFetcher
      ]

      results = klasses.map do |klass|
        klass::SEASONS.map do |season_number|
          klass.new(season_number).gather!
        end
      end

      File.open("svu.txt", "w") do |file|
        file.puts filtered_results(results)
      end
    end

    private

    def filtered_results(results)
      results.flatten.uniq.reject do |episode|
        invalid?(episode) || description_matches_nbc_regex(episode)
      end
    end

    def invalid?(episode)
      episode == INVALID_DESCRIPTION
    end

    def description_matches_nbc_regex(episode)
      episode && episode.encode("UTF-8", invalid: :replace, replace: "? ").match(NBC_REGEX)
    end
  end
end
