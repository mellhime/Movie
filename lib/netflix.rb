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
        elsif !hash.select { |k, _v| @movies.sample.respond_to?(k) }.empty?
          filter_by(hash)
        else
          hash.inject(films) { |_movies, (k, v)| films.select { |film| @filter[k].call(film, v) } }
        end
      end

      @showing_film = @showing_film.is_a?(Array) ? @showing_film.sort_by { |film| film.score.to_f * rand }.last : @showing_film
    end

    def withdraw
      raise 'Not enough money for this film' unless @balance >= Money.new(@showing_film.price * 100, 'USD')
      @balance -= Money.new(@showing_film.price * 100, 'USD')
    end

    def show(*hashes)
      select_film(*hashes)
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
