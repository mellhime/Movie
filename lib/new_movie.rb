module MovieViewer
  class NewMovie < Movie
    attr_accessor :price

    def to_s
      "#{@title} - new film, have been released #{Time.now.year - @year.to_i} years ago,"
    end

    def price
      5
    end
  end
end
