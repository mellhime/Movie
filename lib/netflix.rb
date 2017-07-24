module MovieViewer
  class Netflix < MovieCollection
    extend Cash

    attr_accessor :balance

    def initialize(filename)
      super
      @balance = Money.new(0, 'USD')
      @filter = {}
    end

    def pay(money)
      raise 'Input error!' unless money.is_a?(Integer)
      self.class.pay_in_cash(money)
      @balance += Money.new(money * 100, 'USD')
      puts "Your balance is #{@balance.format}"
    end

    def select_film(*hashes)
      @showing_film = hashes.inject(@movies) do |films, hash|
        if block_given?
          films.select { |film| yield(film) }
        elsif in_default_filters(hash)
          filter_by(hash)
        else
          filter_by_personal_filters(hash, films)

        end
      end

      @showing_film = @showing_film.is_a?(Array) ? @showing_film.sort_by { |film| film.score.to_f * rand }.last : @showing_film
    end

    def in_default_filters(hash)
      !hash.select { |k, _v| @movies.sample.respond_to?(k) }.empty?
    end

    def filter_by_personal_filters(hash, films)
      hash.inject(films) { |_movies, (k, v)| films.select { |film| @filter[k].call(film, v) } }
    end

    def withdraw
      raise 'Not enough money for this film' unless @balance >= Money.new(@showing_film.price * 100, 'USD')
      @balance -= Money.new(@showing_film.price * 100, 'USD')
    end

    def show(*hashes, &block)
      select_film(*hashes, &block)
      withdraw
      puts "Now showing #{@showing_film} start time #{Time.now.strftime('%H:%M')}, end time #{(Time.now + @showing_film.duration.to_i * 60).strftime('%H:%M')}"
    end

    def define_filter(filter_name, from: nil, arg: nil, &block)
      @filter[filter_name] = from.nil? && arg.nil? ? block : proc { |movie| @filter[from].call(movie, arg) }
    end

    def how_much?(movie_name)
      @movies.select { |film| film.title == movie_name }.map { |film| puts "Price = #{film.price}" }
    end
  end
end
