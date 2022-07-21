class CardsController < ApplicationController
  def index
    @cards = Card.all.order(created_at: :desc)
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])

    if @card.update(card_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to root_path
  end

  private

  def card_params
    params.require(:card).permit(:body, :bookmark)
  end
end
