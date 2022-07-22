class CardsController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: 'hunter12', except: %i[index show]

  def index
    @cards = Card.all.order(created_at: :desc)
  end

  def show
    @card = Card.find_by(slug: params[:slug])
  end

  # Author only

  def author_index
    @cards = Card.all.order(created_at: :desc)
    @is_author = true
    render :index
  end

  def author_show
    @card = Card.find_by(slug: params[:slug])
    @is_author = true
    render :show
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to author_index_path
    else
      render :new
    end
  end

  def edit
    @card = Card.find_by(slug: params[:slug])
  end

  def update
    @card = Card.find_by(slug: params[:slug])

    if @card.update(card_params)
      redirect_to author_card_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @card = Card.find_by(slug: params[:slug])
    @card.destroy
    redirect_to author_index_path
  end

  private

  def card_params
    params.require(:card).permit(:body, :bookmark_url, :bookmark_name)
  end

  def is_author?
    @is_author
  end

  helper_method :is_author?
end
