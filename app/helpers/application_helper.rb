module ApplicationHelper

  # Let us embed code segments inside a markdown document
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ["code", language, sha].join('-') do
        Pygments.highlight(code, lexer: language)
      end
    end
  end

  def title(page_title)
    content_for(:title) { h(page_title.to_s) }
  end

  def hide_explanation_sidebar?
    @hide_explanation_sidebar
  end

  def to_markdown(text)
    if text.present?
      renderer = HTMLwithPygments.new
      options = {
        autolink: true,
        hard_wrap: true,
        filter_html: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        tables: true,
      }
      markdown = Redcarpet::Markdown.new(renderer, options).render(text).html_safe
    end
  end

end
