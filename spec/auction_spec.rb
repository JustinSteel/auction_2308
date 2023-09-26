require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.describe Auction do
  before(:each) do
  @auction = Auction.new

  @item1 = Item.new('Chalkware Piggy Bank')
  @item2 = Item.new('Bamboo Picture Frame')

  @attendee = Attendee.new({name: 'Megan', budget: '$50'})
  end

  describe '#Starts empty' do
    it 'starts with no items' do
      expect(@auction.items).to eq([])
    end
  end

  describe '#Adds items' do
    it 'adds items' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)

      expect(@auction.items).to eq([@item1, @item2])
    end
  end

  describe '#Item names' do
    it 'returns item names' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)

      expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end
end