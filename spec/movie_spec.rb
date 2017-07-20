require_relative 'spec_helper.rb'

RSpec.describe Movie do
  let(:collection) { MovieCollection.new('movies.txt') }

  subject (:movie) { Movie.new('http://imdb.com/title/tt0111161/?ref_=chttp_tt_1', 'The Shawshank Redemption', '1994', 'USA', '1994-10-14', 'Crime,Drama', '142 min', '9.3', 'Frank Darabont', 'Tim Robbins,Morgan Freeman,Bob Gunton', collection) }

  its(:year) { is_expected.to eq(1994) }
  its(:stars) { is_expected.to eq(['Tim Robbins', 'Morgan Freeman', 'Bob Gunton']) }
  its(:genre) { is_expected.to eq(%w[Crime Drama]) }
  its(:title) { is_expected.to eq('The Shawshank Redemption') }
  its(:link) { is_expected.to eq('http://imdb.com/title/tt0111161/?ref_=chttp_tt_1') }
  its(:country) { is_expected.to eq('USA') }
  its(:release_date) { is_expected.to eq('1994-10-14') }
  its(:duration) { is_expected.to eq(142) }
  its(:score) { is_expected.to eq(9.3) }
  its(:director) { is_expected.to eq('Frank Darabont') }
  its(:month) { is_expected.to eq('October') }

  describe '#genre?' do
    it 'should raise error if genre doesnt exist' do
      expect { movie.genre?('Tragedy') }.to raise_error(NameError)
    end

    it 'should return true if genre exists and movie has it' do
      expect(movie.genre?('Drama')).to be_truthy
    end

    it 'should return false if movie has not this genre' do
      expect(movie.genre?('Comedy')).to be_falsey
    end
  end

  let(:collection) { MovieCollection.new('movies.txt') }

  describe '#to_s' do
    subject (:movie) { collection.all.select { |film| film.is_a?(class_name) }[0].to_s }

    context 'should print ancient film' do
      let (:class_name) { AncientMovie }
      it { is_expected.to eq('Casablanca - ancient film (1942 year),') }
    end

    context 'should print classic film' do
      let (:class_name) { ClassicMovie }
      it { is_expected.to eq('12 Angry Men - classic movie, director: Sidney Lumet, there are 3 his films in list,') }
    end

    context 'should print modern film' do
      let (:class_name) { ModernMovie }
      it { is_expected.to eq('The Shawshank Redemption - modern movie, stars: Tim Robbins,Morgan Freeman,Bob Gunton,') }
    end

    context 'should print new film' do
      let (:class_name) { NewMovie }
      it { is_expected.to eq('The Dark Knight - new film, have been released 9 years ago,') }
    end
  end
end
