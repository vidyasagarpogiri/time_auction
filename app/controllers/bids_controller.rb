class BidsController < ApplicationController
  def new
    render partial: 'new'
  end

  def create
    @bid = Bid.new params[:bid]
    @bid.user = current_user
    if @bid.auction.bids == []
      @last_bid_time = 0
    else
      @last_bid_time = @bid.auction.bids.last.time
    end
    
    if @bid.time.nil?
      render text: 'Please enter the number of hours you wish to bid!', status: :unprocessable_entity and return
    end

    if @bid.time <= @last_bid_time
      render text: 'Your bid must be higher than the current highest bid!', status: :unprocessable_entity and return
    end

    if @bid.auction.end_date <= Time.now
      render text: 'Sorry!  This auction has ended.  Try another one?', status: :unprocessable_entity and return
    end

    if @bid.save
      render text: render_to_string(partial: 'bid', locals: { bid: @bid })
    else
      render text: @bid.errors.full_messages.join(','), status: :unprocessable_entity
    end
  end
end