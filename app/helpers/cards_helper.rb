require 'redcarpet'

module CardsHelper
  def card_body_html(card)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      escape_html: true
    )
    markdown.render(card.body)
  end
end
