module MovieViewer
  class ClassicMovie < Movie
    attr_accessor :price

    def to_s
      "#{@title} - classic movie, director: #{@director}, there are #{@collection.all.select { |film| film.director == @director }.count} his films in list,"
    end

    def price
      1.5
    end
  end
end
