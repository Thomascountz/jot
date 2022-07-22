require 'redcarpet'
module CardsHelper
  class CustomRender < Redcarpet::Render::HTML
    def image(link, _title, alt_text)
      %(<a href="#{link}" target="_blank"><img src="#{link}" alt="#{alt_text}"></a>)
    end
  end

  def card_body_html(card)
    markdown = Redcarpet::Markdown.new(
      CustomRender,
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      escape_html: true,
      strikethrough: true
    )
    markdown.render(card.body)
  end
end
