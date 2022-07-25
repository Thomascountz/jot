class CardsController < ApplicationController
  PER_PAGE = 8
  http_basic_authenticate_with name: ENV.fetch('AUTH_USER'), password: ENV.fetch('AUTH_PASS'), except: %i[index show]

  def index
    @query = params[:query]
    @tag = params[:tag]
    @cards = if @query.present?
               Card.search(@query).where(public: true)
             elsif @tag.present?
               @cards = Card.tagged_with(@tag).order(created_at: :desc).where(public: true)
             else
               Card.all.order(created_at: :desc).where(public: true)
             end.limit(PER_PAGE).offset(paginate_offset)
  end

  def show
    @card = Card.find_by(slug: params[:slug], public: true)
    render body: nil, status: :not_found unless @card
  end

  def tag
    @cards = Card.tagged_with(params[:tag])
                 .order(created_at: :desc)
                 .limit(PER_PAGE)
                 .offset(paginate_offset)
    render :index
  end

  # Author only

  def author_index
    @is_author = true
    @query = params[:query]
    @tag = params[:tag]
    @cards = if @query.present?
               Card.search(@query)
             elsif @tag.present?
               @cards = Card.tagged_with(@tag).order(created_at: :desc)
             else
               Card.all.order(created_at: :desc)
             end.limit(PER_PAGE).offset(paginate_offset)
    render :index
  end

  def author_show
    @is_author = true
    @card = Card.find_by(slug: params[:slug])
    render :show
  end

  def author_tag
    @is_author = true
    @cards = Card.tagged_with(params[:tag])
                 .order(created_at: :desc)
                 .limit(PER_PAGE)
                 .offset(paginate_offset)
    render :index
  end

  def new
    @is_author = true
    @card = Card.new
  end

  def create
    ActiveRecord::Base.transaction do
      @card = Card.new(card_params.except(:tags))
      find_or_create_with_tags
      if @card.save
        redirect_to author_index_path
      else
        render :new
      end
    end
  end

  def edit
    @is_author = true
    @card = Card.find_by(slug: params[:slug])
  end

  def update
    ActiveRecord::Base.transaction do
      @card = Card.find_by(slug: params[:slug])
      find_or_create_with_tags

      if @card.update(card_params.except(:tags))
        redirect_to author_card_path
      else
        render :edit, status: :unprocessable_entity
      end
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
    params.require(:card).permit(:body, :bookmark_url, :bookmark_name, :public, :tags)
  end

  def find_or_create_with_tags
    @card.tags.destroy_all
    tag_params = card_params[:tags]

    return if tag_params.blank?

    JSON.parse(tag_params).each do |tag|
      name = Tag.normalize_name(tag['value'])
      @card.tags << Tag.find_or_initialize_by(name:)
    end
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

  def final_page_no(is_author)
    if is_author
      (Card.count / PER_PAGE.to_f).ceil
    else
      (Card.where(public: true).count / PER_PAGE.to_f).ceil
    end
  end
end
