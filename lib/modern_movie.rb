module MovieViewer
  class ModernMovie < Movie
    attr_accessor :price

    def to_s
      "#{@title} - modern movie, stars: #{@stars},"
    end

    def price
      3
    end
  end
end
