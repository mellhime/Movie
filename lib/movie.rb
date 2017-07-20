module MovieViewer
  class Movie
    attr_accessor :link, :title, :year, :country, :release_date, :genre, :duration, :score, :director, :stars, :collection, :to_s, :period

    ANCIENT = 1800..1945
    CLASSIC = 1946..1968
    MODERN = 1969..2000
    NEW = 2001..Time.now.year

    def initialize(link, title, year, country, release_date, genre, duration, score, director, stars, collection) # rubocop:disable ParameterLists
      @link = link
      @title = title
      @year = year
      @country = country
      @release_date = release_date
      @genre = genre
      @duration = duration
      @score = score
      @director = director
      @stars = stars
      @collection = collection
    end

    def self.create(line, collection)
      parameters = line.values.flatten << collection
      case line[:year].to_i
      when ANCIENT then AncientMovie.new(*parameters)
      when CLASSIC then ClassicMovie.new(*parameters)
      when MODERN then ModernMovie.new(*parameters)
      when NEW then NewMovie.new(*parameters)
      end
    end

    def to_s
      "#{@title} - фильм #{@year} года, режиссер #{@director}, играют #{stars}"
    end

    def genre?(genre_name)
      raise NameError unless @collection.genre_exists?(genre_name)
      @genre.include?(genre_name)
    end

    def month
      Date::MONTHNAMES[Date.strptime(@release_date, '%Y-%m').mon] if @release_date.length > 4
    end

    def year
      @year.to_i
    end

    def stars
      @stars.split(',')
    end

    def genre
      @genre.split(',')
    end

    def score
      @score.to_f
    end

    def duration
      @duration.to_i
    end

    def period
      self.class.name.gsub!('MovieViewer::', '').downcase.gsub!('movie', '').to_sym
    end
  end
end
