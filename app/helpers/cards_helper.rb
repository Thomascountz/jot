require 'redcarpet'
require 'action_view'

module CardsHelper
  class CustomRender < Redcarpet::Render::HTML
    include ActionView::Helpers::AssetTagHelper

    # Ensure rendered images' widths are capped
    def image(link, title, alt_text)
      image_tag(link, title: title, alt: alt_text, style: "max-width:100%")
    end
  end

  def card_body_html(card)
    markdown = Redcarpet::Markdown.new(
      CustomRender,
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      escape_html: true
    )
    markdown.render(card.body)
  end
end
