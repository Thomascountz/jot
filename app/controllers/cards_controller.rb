class CardsController < ApplicationController
  def index
    @cards = Card.all.order(created_at: :desc)
  end

  def new
    @card = Card.new
  end
end
