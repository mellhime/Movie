require_relative 'spec_helper.rb'

RSpec.describe Theatre do
  describe '#show' do # может показывать фильм в зависимости от переданного времени
    let(:theatre) { Theatre.new('movies_for_filter_by.txt') }

    before(:each) do
      theatre.cash
    end

    it 'should be able to showing morning film' do
      expect { theatre.show(10) }.to output(/The Maltese Falcon/).to_stdout
    end

    it 'should be able to showing day film' do
      expect { theatre.show(14) }.to output(/Interstellar/).to_stdout
    end

    it 'should be able to showing evening film' do
      expect { theatre.show(21) }.to output(/The Dark Knight Rises/).to_stdout
    end

    it 'should raise error at night time' do
      expect { theatre.show(3) }.to raise_error("Cinema doesn't work at night")
    end

    before do
      Timecop.freeze('11:15:00')
    end

    it 'should be able to show start time and end time' do
      expect { theatre.show(15) }.to output("Now showing Interstellar - new film, have been released 3 years ago, start time 11:15, end time 14:04\n").to_stdout
    end
  end

  describe '#when?' do # может сказать когда идет тот или иной фильм
    let(:theatre) { Theatre.new('movies.txt') }

    context 'film exists in list' do
      it "theatre.when?('V for Vendetta')" do
        expect { theatre.when?('V for Vendetta') }.to output("V for Vendetta - new film, have been released 12 years ago, you can watch in 19..24 hours\n").to_stdout
      end

      it "theatre.when?('The Gold Rush')" do
        expect { theatre.when?('Interstellar') }.to output("Interstellar - new film, have been released 3 years ago, you can watch in 12..18 hours\n").to_stdout
      end
    end

    context "film doesn't exists in list" do
      it "can't print the showing time if film doesnt exist" do
        expect { theatre.when?('Clannad') }.to raise_error("This film doesn't exist in my collection")
      end
    end
  end
end
