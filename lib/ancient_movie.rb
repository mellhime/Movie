module MovieViewer
  class AncientMovie < Movie
    attr_accessor :price

    def to_s
      "#{@title} - ancient film (#{@year} year),"
    end

    def price
      1
    end
  end
end
