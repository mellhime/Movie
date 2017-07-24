require_relative 'spec_helper.rb'

RSpec::Matchers.define :be_sorted_by do |field|
  match do |new_collection|
    a = new_collection.map { |film| film.send(field) }
    a.sort == a
  end

  failure_message do |_actual|
    "expected to be sorted by #{field} but sorted by smth else"
  end
end

RSpec.describe MovieCollection do
  let (:new_collection) { MovieCollection.new('movies.txt') }

  describe '#new' do
    subject { new_collection.all.select { |film| period.include?(film.year) } }

    context 'should make ancients films' do
      let(:period) { (1800..1945) }
      it { is_expected.to all be_kind_of(AncientMovie) }
    end

    context 'should make classic films' do
      let(:period) { (1946..1968) }
      it { is_expected.to all be_kind_of(ClassicMovie) }
    end

    context 'should make modern films' do
      let(:period) { (1969..2000) }
      it { is_expected.to all be_kind_of(ModernMovie) }
    end

    context 'should make new films' do
      let(:period) { (2001..Time.now.year) }
      it { is_expected.to all be_kind_of(NewMovie) }
    end
  end

  subject (:new_collection) { MovieCollection.new('movies.txt') }

  its(:all) { is_expected.to be_kind_of(Array) } # проверяет что выводится массив всех фильмов

  its('all.first.stars') { is_expected.to eq(['Tim Robbins', 'Morgan Freeman', 'Bob Gunton']) } # печатает актеров из первого фильма

  describe '#sort_by' do # может сортировать фильмы по полям: год, страна
    subject { new_collection.sort_by(field) }

    context 'field exists' do
      let (:field) { :year }
      it { is_expected.to be_sorted_by(field) }
    end

    context 'field doesnt exist' do
      let (:field) { :compositor }
      it { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  describe '#filter_by' do # может выдавать список фильмов по переданным фильтрам
    it "new_collection.filter_by({genre: 'Drama'})" do
      expect(new_collection.filter_by(genre: 'Drama')).to all have_attributes(genre: ['Drama'])
    end

    it "new_collection.filter_by({genre: 'Triller', year: 1960, period: 'classic'})" do
      expect(new_collection.filter_by(genre: 'Triller', year: 1960, period: 'classic')).to all have_attributes(genre: 'Triller', year: 1960, period: 'classic')
    end
  end

  describe '#stat' do # может выводить статистику по разным полям
    it 'should return statistics' do
      expect(new_collection.stat(:month)).to eq('October' => 19, 'March' => 21, 'December' => 30, 'July' => 18, 'April' => 15, 'February' => 24, 'June' => 24, 'November' => 19, 'September' => 20, 'May' => 21, 'January' => 19, 'August' => 17)
    end

    it 'should return statistics by country' do
      expect(new_collection.stat(:country)).to eq('USA' => 166, 'Italy' => 11, 'New Zealand' => 1, 'Japan' => 15, 'Brazil' => 2, 'France' => 10, 'Germany' => 4, 'South Korea' => 3, 'West Germany' => 1, 'UK' => 19, 'Australia' => 2, 'Iran' => 1, 'India' => 1, 'Denmark' => 1, 'Spain' => 1, 'Sweden' => 4, 'Argentina' => 2, 'Canada' => 1, 'Mexico' => 1, 'Ireland' => 1, 'Soviet Union' => 1, 'Hong Kong' => 2)
    end
  end

  describe '#Enumerable' do
    it '#select' do
      expect { puts new_collection.select { |film| film.title == 'The Lion King' } }.to output("The Lion King - modern movie, stars: Matthew Broderick,Jeremy Irons,James Earl Jones,\n").to_stdout
    end

    it '#any?' do
      expect(new_collection.any? { |film| film.country == 'Hong Kong' }).to be_truthy
    end

    it '#map' do
      expect(new_collection.map { |_film| 'deleted film' }).to eq(['deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film', 'deleted film'])
    end
  end
end
