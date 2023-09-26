require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.describe Auction do
  before(:each) do
  @auction = Auction.new

  @item1 = Item.new('Chalkware Piggy Bank')
  @item2 = Item.new('Bamboo Picture Frame')
  @item3 = Item.new('Homemade Chocolate Chip Cookies')
  @item4 = Item.new('2 Days Dogsitting')
  @item5 = Item.new('Forever Stamps')

  @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
  @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
  @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
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

  describe '#bid' do
    it 'starts with no bids' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      expect(@item1.bids).to eq({})
    end

    it 'adds bids' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)

      expect(@item1.bids).to eq({@attendee2 => 20, @attendee1 => 22})
    end

    it 'returns highest bid' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)

      expect(@item1.current_high_bid).to eq(22)
    end
  end

  describe '#unpopular_items' do
    it 'returns unpopular items' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)

      expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])

      @item3.add_bid(@attendee2, 15)

      expect(@auction.unpopular_items).to eq([@item2, @item5])
    end
  end

  describe '#potential_revenue' do
    it 'returns potential revenue' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)

      expect(@auction.potential_revenue).to eq(87)
    end
  end

  describe '#bidders' do
    it 'returns an array of bidder names' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)

    expect(@auction.bidders.sort).to eq(["Bob", "Megan", "Mike"])  
    end

    it 'returns a hash of bidder info' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)

      expected = {
        @attendee2 => {
          :budget => 75,
          :items => [@item1, @item2]
        },
        @attendee1 => 
        {
          :budget => 50,
          :items => [@item1]
        },
        @attendee3 => {
          :budget => 100,
          :items => [@item1]
        },
        }
        
        expect(@auction.bidder_info).to eq(expected)
    end
  end
end