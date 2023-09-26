require './lib/attendee'
require './lib/item'
require './lib/auction'

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@item1).to be_a Item
    end
  end

  describe '#attributes' do
    it 'has a name' do
      expect(@item1.name).to eq('Chalkware Piggy Bank')
    end
  end
end