require './lib/attendee'
require './lib/item'
require './lib/auction'

RSpec.describe Auction do
  before(:each) do
    @attendee = Attendee.new({name: 'Megan', budget: '$50'})
  end

  describe '#attributes' do
    it 'has name and budget' do
      expect(@attendee.name).to eq("Megan")
      expect(@attendee.budget).to eq(50)
    end
  end
end