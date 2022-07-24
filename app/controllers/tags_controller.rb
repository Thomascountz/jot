class TagsController < ApplicationController
  def search
    query = params[:query]
    data = if query.blank?
             Tag
               .joins(:taggables)
               .group('tags.id')
               .order('count(tags.id) DESC')
               .limit(20)
           else
             Tag
               .where('name LIKE ?', "#{params[:q]}%")
               .limit(20)
           end.map { |tag| { value: tag.name } }
    render json: data
  end
end
