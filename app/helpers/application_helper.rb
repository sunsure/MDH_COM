module ApplicationHelper

  def title(page_title)
    content_for(:title) { h(page_title.to_s) }
  end

  def hide_explanation_sidebar?
    @hide_explanation_sidebar
  end

  def to_markdown(text)
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
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end

end
