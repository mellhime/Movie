module MovieViewer
  class MovieCollection
    include Enumerable

    attr_accessor :movies, :all_genres

    ANCIENT = 1800..1945
    CLASSIC = 1946..1968
    MODERN = 1969..2000
    NEW = 2001..Time.now.year

    HEADERS = %i[link title year country release_date genre duration score director stars].freeze

    def initialize(filename)
      @movies = CSV.open(filename, col_sep: '|', headers: HEADERS).map(&:to_h).map do |line|
        Movie.create(line, self)
      end

      @all_genres = @movies.flat_map { |film| film.send(:genre) }.sort.uniq
    end

    def each(&block)
      @movies.each(&block)
    end

    def all
      @movies
    end

    def sort_by(par)
      @movies.sort_by(&par)
    end

    def filter_by(hash)
      hash.inject(@movies) do |films, (key, value)|
        films.select do |film|
          value === (film.send(key).is_a?(Array) ? film.send(key).join(',') : film.send(key)) # rubocop:disable CaseEquality
        end
      end
    end

    def stat(par)
      @movies.flat_map(&par).group_by(&:itself).map { |key, value| [key, value.count] }.to_h.delete_if { |key, _value| key.nil? }
    end

    def first
      @movies.first
    end

    def genre_exists?(genre_name)
      @all_genres.include?(genre_name)
    end
  end
end
