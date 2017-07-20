module MovieViewer
  module Cash
    def cash
      @cash ||= Money.new(0, 'USD')
    end

    def pay_in_cash(money)
      cash
      @cash += Money.new(money * 100, 'USD')
    end

    def take(who)
      raise 'Alarm!' unless who == 'Bank'
      @cash = Money.new(0, 'USD')
      puts "Incassation has been completed. Cash #{@cash}"
    end
  end
end
