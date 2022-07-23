class CardsController < ApplicationController
  PER_PAGE = 8
  http_basic_authenticate_with name: 'admin', password: 'hunter12', except: %i[index show]

  def index
    @query = params[:query]
    @cards = if @query.blank?
               Card.all.order(created_at: :desc)
             else
               Card.search(params[:query])
             end.limit(PER_PAGE).offset(paginate_offset)
    @final_page_no = (@cards.count / PER_PAGE)
  end

  def show
    @card = Card.find_by(slug: params[:slug])
  end

  # Author only

  def author_index
    @is_author = true
    @query = params[:query]
    @cards = if @query.blank?
               Card.all.order(created_at: :desc)
             else
               Card.search(params[:query])
             end.limit(PER_PAGE).offset(paginate_offset)
    @final_page_no = (@cards.count / PER_PAGE)
    render :index
  end

  def author_show
    @is_author = true
    @card = Card.find_by(slug: params[:slug])
    render :show
  end

  def new
    @is_author = true
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
    @is_author = true
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

  helper_method :is_author?, :page_no, :final_page_no

  def card_params
    params.require(:card).permit(:body, :bookmark_url, :bookmark_name)
  end

  def is_author?
    @is_author
  end

  def page_no
    params[:page]&.to_i || 1
  end

  def paginate_offset
    (page_no - 1) * PER_PAGE
  end

  def final_page_no
    @final_page_no || 1
  end
end
