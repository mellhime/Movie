require_relative 'spec_helper.rb'

RSpec.describe Netflix do
  subject (:netflix) { Netflix.new('movies.txt') }

  describe '#show' do
    context 'when enough money' do
      before do
        netflix.pay(50)
      end

      subject { netflix.show(filter) }

      context 'simple filters' do
        let(:filter) { { genre: /riller/, year: 1960, period: :classic } }
        it { expect { subject }.to output(/Psycho - classic movie, director: Alfred Hitchcock/).to_stdout }
      end

      context 'complex filter' do
        before do
          netflix.define_filter(:new_sci_fi) { |movie| movie.period == :new && movie.genre.include?('Sci-Fi') && movie.director == 'Bryan Singer' }
        end

        let(:filter) { { new_sci_fi: true } }
        it { expect { subject }.to output(/Now showing X-Men: Days of Future Past - new film, have been released 3 years ago/).to_stdout }
      end

      context 'complex filter with an additional parameter' do
        before do
          netflix.define_filter(:ancient_comedy) { |movie, country| movie.country == country && movie.year == 1925 && movie.genre.include?('Comedy') }
        end

        let(:filter) { { ancient_comedy: 'USA' } }
        it { expect { subject }.to output(/Now showing The Gold Rush - ancient film (1925 year)/).to_stdout }
      end

      context 'with block filter' do
        it 'should be able to showing film with block filter' do
          expect { netflix.show(period: :new) { |movie| !movie.title.include?('Terminator') && movie.genre.include?('Action') && movie.year > 2014 } }.to output(/Now showing Mad Max: Fury Road - new film, have been released 2 years ago/).to_stdout
        end
      end

      context 'with very complex filters' do
        before do
          netflix.define_filter(:new_sci_fi) { |movie, year| movie.year > year && movie.period == :new && movie.genre.include?('Sci-Fi') }
          netflix.define_filter(:newest_sci_fi, from: :new_sci_fi, arg: 2010)
        end

        it 'should be able to showing film with very complex filters' do
          expect { netflix.show({ director: 'Christopher Nolan' }, newest_sci_fi: true) }.to output(/Now showing Interstellar - new film, have been released 3 years ago/).to_stdout
        end
      end
    end

    context 'when not enough money' do
      it 'should not be able to show movies with no money' do
        expect { netflix.show(genre: /riller/, year: (1925..2000), period: :classic) }.to raise_error('Not enough money for this film')
      end
    end
  end

  describe '#pay' do
    before do
      netflix.pay(10)
    end

    its(:balance) { is_expected.to eq(Money.new(10 * 100, 'USD')) }

    it 'should not be able to change balance if user input isnt Integer' do
      expect { netflix.pay('dfdf') }.to raise_error("Input error!")
    end
  end

  describe '#how_much?' do
    context 'film exists in collection' do
      it 'show films price if film exists in collection' do
        expect { netflix.how_much?('The Gold Rush') }.to output("Price = 1\n").to_stdout
      end
    end

    context "film doesn't exists in collection" do
      it 'do not show films price if film does not exists in collection' do
        expect { netflix.how_much?('Clannad') }.to output('').to_stdout
      end
    end
  end
end
