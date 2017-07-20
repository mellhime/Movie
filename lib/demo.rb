require_relative 'movie_analyzer.rb'
include MovieViewer

new_collection = MovieCollection.new('movies.txt')

# TASK 5

# #Вывести все фильмы
new_collection.all
# # # Сортировка
# new_collection.sort_by(:year)
# # # Статистика
# new_collection.stat(:country)
# # # Список актеров в первом фильме
# new_collection.all.first.stars

# # Запрос genre?

# begin

# 	new_collection.all.first.genre?("Tragedy")
# 	rescue NameError
# 		puts 'We know about this error'
# end
# 	puts 'Programm continued'
# 	puts new_collection.all.first.genre?("Drama")

# # Фильтр
# new_collection.filter_by({stars: /Charles/, period: :ancient})

# ------------------------------------------------------------

# TASK 6

# netflix = Netflix.new('movies.txt')

# #в объект можно положить денег (например netflix.pay(25))
# netflix.pay(5)

# #печатают «Now showing: (название выбранного кина) (время начала) - (время окончания)»
# #можно передать фильтры, например netflix.show(genre: 'Comedy', period: :classic)

# netflix.show({stars: /Charles/, period: :ancient})

# #можно спросить, сколько стоит нужное кино: netflix.how_much?('The Terminator')
# netflix.how_much?("The Gold Rush")

# theatre = Theatre.new('movies.txt')

# # #печатают «Now showing: (название выбранного кина) (время начала) - (время окончания)»
# # #можно передать время, в которое вы хотите посмотреть кино; и в зависимости от этого утром будут старые фильмы, днём — комедии и приключения; вечером — драмы и ужастики;
# theatre.show(14)

# # #можно спросить, когда можно посмотреть нужное кино: theater.when?('The Terminator')
# theatre.when?("It Happened One Night")

# ------------------------------------------------------------

# TASK 7

# netflix = Netflix.new('movies.txt')

# # количество денег в кассе должен возвращать метод Neflix.cash
# puts Netflix.cash

# # онлайн-кинотеатр кладёт деньги в кассу при вызове метода pay
# netflix.pay(5)

# # у обоих кинотеатров есть метод take(who)
# Netflix.take("Bank")

# theatre = Theatre.new('movies.txt')

# puts theatre.cash

# theatre.show(14)

# # у обоих кинотеатров есть метод take(who)
# theatre.take("Bank")

# ------------------------------------------------------------

# TASK 8

netflix = Netflix.new('movies.txt')

# #в объект можно положить денег (например netflix.pay(25))
netflix.pay(50)

# #печатают «Now showing: (название выбранного кина) (время начала) - (время окончания)»
# #можно передать фильтры, например netflix.show(genre: 'Comedy', period: :classic)
puts "\xD0\xBE\xD0\xB1\xD1\x8B\xD1\x87\xD0\xBD\xD1\x8B\xD0\xB9 \xD1\x84\xD0\xB8\xD0\xBB\xD1\x8C\xD1\x82\xD1\x80 \xD0\xB8\xD0\xB7 TASK 6"
netflix.show(stars: /Charles/, period: :ancient)

# то есть пользователь может передать любой блок кода, в который приходит кино и результат которого используется для фильтрации
puts "\xD0\xBE\xD0\xB1\xD1\x8B\xD1\x87\xD0\xBD\xD1\x8B\xD0\xB9 \xD0\xB8 \xD0\xB1\xD0\xBB\xD0\xBE\xD0\xBA (2 \xD0\xB7\xD0\xB0\xD0\xB4\xD0\xB0\xD0\xBD\xD0\xB8\xD0\xB5)"
netflix.show(period: :new) { |movie| !movie.title.include?('Terminator') && movie.genre.include?('Action') && movie.year > 2003 }

# теперь позволим пользователю сохранять такие блоки-фильтры для дальнейшего использования — в конце концов,
# скорее всего он часто задаёт одни и те же запросы
# («фантастический фильм из новых, кроме тех что снимает Эммерих, ненавижу его! и, пожалуй, не британский»).
# Пусть можно будет сделать так: netflix.define_filter(:new_sci_fi) { ...... }, а потом netflix.show(new_sci_fi: true);

puts "\xD1\x84\xD0\xB8\xD0\xBB\xD1\x8C\xD1\x82\xD1\x80 define_filter(3 \xD0\xB7\xD0\xB0\xD0\xB4\xD0\xB0\xD0\xBD\xD0\xB8\xD0\xB5)"
netflix.define_filter(:new_sci_fi) { |movie| movie.period == :new && movie.genre.include?('Sci-Fi') }
netflix.show(new_sci_fi: true)

puts "\xD1\x84\xD0\xB8\xD0\xBB\xD1\x8C\xD1\x82\xD1\x80 define_filter(3 \xD0\xB7\xD0\xB0\xD0\xB4\xD0\xB0\xD0\xBD\xD0\xB8\xD0\xB5)"
netflix.define_filter(:ancient_comedy) { |movie| movie.period == :ancient && movie.genre.include?('Comedy') }
netflix.show(ancient_comedy: true)

# (у его личного фильтра — дополнительные параметры):
# netflix.define_filter(:new_sci_fi) { |movie, year| movie.year > year && ... },
# а потом netflix.show(new_sci_fi: 2010)
puts "\xD1\x84\xD0\xB8\xD0\xBB\xD1\x8C\xD1\x82\xD1\x80 define_filter(4 \xD0\xB7\xD0\xB0\xD0\xB4\xD0\xB0\xD0\xBD\xD0\xB8\xD0\xB5)"
netflix.define_filter(:new_sci_fi) { |movie, year| movie.year > year && movie.period == :new && movie.genre.include?('Sci-Fi') }
netflix.show(new_sci_fi: 2014)

puts "\xD1\x84\xD0\xB8\xD0\xBB\xD1\x8C\xD1\x82\xD1\x80 define_filter(4 \xD0\xB7\xD0\xB0\xD0\xB4\xD0\xB0\xD0\xBD\xD0\xB8\xD0\xB5)"
netflix.define_filter(:ancient_comedy) { |movie, country| movie.country == country && movie.genre.include?('Comedy') }
netflix.show(ancient_comedy: 'USA')

# И он хочет сначала определить один фильтр, а потом другие на его основе. Вот так:
# netflix.define_filter(:new_sci_fi) { |movie, year| movie.year > year && ... },
# а затем netflix.define_filter(:newest_sci_fi, from: :new_sci_fi, arg: 2014)
# (то есть из более общего фильтра определить частный). Надо дать ему такую возможность!
puts "\xD1\x84\xD0\xB8\xD0\xBB\xD1\x8C\xD1\x82\xD1\x80 define_filter(5 \xD0\xB7\xD0\xB0\xD0\xB4\xD0\xB0\xD0\xBD\xD0\xB8\xD0\xB5)"
netflix.define_filter(:new_sci_fi) { |movie, year| movie.year > year && movie.period == :new && movie.genre.include?('Sci-Fi') }
netflix.define_filter(:newest_sci_fi, from: :new_sci_fi, arg: 2014)
netflix.show(newest_sci_fi: true)

puts "\xD0\xBD\xD0\xB5\xD1\x81\xD0\xBA\xD0\xBE\xD0\xBB\xD1\x8C\xD0\xBA\xD0\xBE \xD1\x84\xD0\xB8\xD0\xBB\xD1\x8C\xD1\x82\xD1\x80\xD0\xBE\xD0\xB2"
netflix.define_filter(:new_sci_fi) { |movie| movie.period == :new && movie.genre.include?('Sci-Fi') }
netflix.show({ new_sci_fi: true }, year: 2014)

puts "\xD0\xBD\xD0\xB5\xD1\x81\xD0\xBA\xD0\xBE\xD0\xBB\xD1\x8C\xD0\xBA\xD0\xBE \xD1\x84\xD0\xB8\xD0\xBB\xD1\x8C\xD1\x82\xD1\x80\xD0\xBE\xD0\xB2"
netflix.define_filter(:new_sci_fi) { |movie, year| movie.year > year && movie.period == :new && movie.genre.include?('Sci-Fi') }
netflix.show(new_sci_fi: 2005) { |movie| movie.country != 'USA' }

puts "\xD0\xBD\xD0\xB5\xD1\x81\xD0\xBA\xD0\xBE\xD0\xBB\xD1\x8C\xD0\xBA\xD0\xBE \xD1\x84\xD0\xB8\xD0\xBB\xD1\x8C\xD1\x82\xD1\x80\xD0\xBE\xD0\xB2"
netflix.define_filter(:new_sci_fi) { |movie, year| movie.year > year && movie.period == :new && movie.genre.include?('Sci-Fi') }
netflix.define_filter(:newest_sci_fi, from: :new_sci_fi, arg: 2010)
netflix.show({ director: 'Christopher Nolan' }, newest_sci_fi: true)
