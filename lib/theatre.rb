module MovieViewer
  class Theatre < MovieCollection
    include Cash

    FILM_TYPES = { MORNING_FILMS: { period: :ancient }, EVENING_FILMS: { genre: /(Thriller)|(Action)/ }, DAY_FILMS: { genre: /(Comedy)|(Adventure)/ } }.freeze

    TIMES = { MORNING_FILMS: (8..11), DAY_FILMS: (12..18), EVENING_FILMS: (19..24) }.freeze

    def select_film(time)
      raise "Cinema doesn't work at night" unless time > 7

      @showing_film = filter_by(FILM_TYPES[TIMES.detect { |_films, period| period.include?(time) }[0]]).sort_by { |film| film.score.to_f * rand }.last
    end

    def show(time)
      select_film(time)
      puts "Now showing #{@showing_film} start time #{Time.now.strftime('%H:%M')}, end time #{(Time.now + @showing_film.duration.to_i * 60).strftime('%H:%M')}"
      pay_in_cash(@showing_film.price)
    end

    def when?(movie_name)
      needed_film = @movies.select { |film| film.title == movie_name }
      raise "This film doesn't exist in my collection" if needed_film.empty?

      FILM_TYPES.each do |films, filter|
        if filter_by(filter).include?(needed_film[0])
          puts "#{needed_film[0]} you can watch in #{TIMES[films]} hours"
          break
        end
      end
    end
  end
end
