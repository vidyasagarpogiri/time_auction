class UsersController < ApplicationController
  def new
    if current_user
      flash[:success] = "You've already logged in :)"
      redirect_to(current_user)
    end
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome, #{@user.name}!"
      sign_in(@user)
      redirect_back_or(user_path(@user))
    else
      flash.now[:errors] = @user.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @winning_auctions = Auction.where("winner_id = ?", params[:id])
    @bids = @user.bids
  end
end
