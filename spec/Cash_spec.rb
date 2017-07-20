require_relative 'spec_helper.rb'

RSpec.describe Cash do
  let(:empty_object) { Object.new }

  before(:each) do
    empty_object.extend(Cash)
  end

  describe '#cash' do
    it 'should be able to save money in cash' do
      expect(empty_object.cash).to eq(Money.new(0, 'USD'))
    end
  end

  describe '#pay_in_cash' do
    it 'should be able to pay in cash' do
      expect { empty_object.pay_in_cash(20) }.to change(empty_object, :cash).by(Money.new(20 * 100, 'USD'))
    end
  end

  describe '#take' do
    it 'should be able to call the police' do
      expect { empty_object.take('Robber') }.to raise_error('Alarm!')
    end

    it 'should be able to clear the cash' do
      expect { empty_object.take('Bank') }.to output("Incassation has been completed. Cash 0.00\n").to_stdout
    end

    before do
      empty_object.pay_in_cash(3)
    end

    it 'should be able to change the cash' do
      expect { empty_object.take('Bank') }.to change { empty_object.cash }.from(Money.new(3 * 100, 'USD')).to(Money.new(0, 'USD'))
    end
  end
end
