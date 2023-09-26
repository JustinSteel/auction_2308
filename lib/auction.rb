class Auction
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map { |item| item.name }
  end

  def unpopular_items
    @items.select { |item| item.bids.empty? }
  end

  def potential_revenue
    @items.map { |item| item.current_high_bid.to_i }.sum
  end

  def bidders
    @items.map do |item|
      item.bids.keys.flat_map do |attendee|
        # require 'pry'; binding.pry
        if attendee.name != nil
          attendee.name
        end
      end
    end.compact.flatten.uniq
  end

  
  
  def items_bid_on
    all_items = [] 
    
    @items.map do |item|
      item.bids.keys.flat_map do |attendee|
        if !unpopular_items.include?(item)
          all_items << item
        end
      end
      # require 'pry'; binding.pry
      all_items.uniq
    end
  end
  
  def bidder_info
    attendee_info = {}
  
    @items.each do |item|
      item.bids.each do |attendee, amount|
        if attendee_info[attendee]
          attendee_info[attendee][:budget] -= amount
          attendee_info[attendee][:items] << item
        else
          attendee_info[attendee] = {
            budget: attendee.budget,
            items: [item]
          }
        end
      end
    end

    attendee_info
  end
end