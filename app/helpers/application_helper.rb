module ApplicationHelper

  # Let us embed code segments inside a markdown document
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ["code", language, sha].join('-') do
        begin
          Pygments.highlight(code, lexer: language)
        rescue Exception => e
          # If they give us some garbage language for the lexer, it shouldn't blow up
          Pygments.highlight(code, lexer: 'text')
        end
      end
    end
  end

  def title(page_title)
    content_for(:title) { page_title.to_s }
  end

  def show_sidebar_carousel?
    @show_sidebar_carousel
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

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn", data: {id: id, fields: fields.gsub("\n", "")})
  end

end
