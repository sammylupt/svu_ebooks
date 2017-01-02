module SvuEbooks
  class Populator

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

      File.open("../svu.txt", "w") do |file|
        file.puts filtered_results(results)
      end
    end

    private

    def filtered_results(results)
      invalid_description = "Know what this is about?\n Be the first one to add a plot."
      nbc_regex = /-- \(C\) NBC/

      results.flatten.uniq.reject do |episode|
        episode == invalid_description ||
        episode.match(nbc_regex)
      end
    end
  end
end
