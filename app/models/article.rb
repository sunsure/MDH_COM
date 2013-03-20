class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :images, as: :assetable, class_name: "Image", dependent: :destroy
  has_one :icon, as: :assetable, class_name: "Icon", dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: proc { |image| image[:attachment].blank? }
  accepts_nested_attributes_for :icon, allow_destroy: true, reject_if: proc { |icon| icon[:attachment].blank? }

  attr_accessor :publish

  acts_as_taggable

  validates :title, presence: true
  validates :content, presence: true
  validates :excerpt, presence: true
  validates :permalink, presence: true, uniqueness: { case_sensitive: false }

  before_validation :set_published_at
  before_create :parameterize_permalink

  scope :draft, where(Article.arel_table[:published_at].eq(nil))
  scope :published, where(Article.arel_table[:published_at].not_eq(nil))
  default_scope order("published_at DESC")

  paginates_per 10

  def to_param
    permalink
  end

  def pretty_tag_list(options={})
    # TODO: make it be able to pass in admin
    # also write tests for me
    result = ""
    result << "<ul class='breadcrumb tag-list'>"
    result << ""
    tag_list.each do |tag|
      result << "<li>"
      result << ActionController::Base.helpers.link_to(tag, Rails.application.routes.url_helpers.tag_articles_path(tag))
      result << "<span class='divider'>/</span>" unless tag == tag_list.last
      result << "</li>"
    end
    result << "</ul>"
    result
  end

  def generate_open_graph_meta_tags
    result = ""
    if icon.present?
      result << "<meta property='og:image' content='#{Rails.application.routes.url_helpers.root_url(host: Rails.application.config.super_cool_mailer_host).gsub(/\/$/, '')}#{icon.url(:thumb)}'/>"
    else
      result << "<meta property='og:image' content='#{Rails.application.routes.url_helpers.root_url(host: Rails.application.config.super_cool_mailer_host)}images/favicon.png'/>"
    end
    result << "<meta property='og:title' content=#{title.inspect}/>"
    result << "<meta property='og:description' content=#{pretty_excerpt}/>"
    result << "<meta property='og:url' content='#{Rails.application.routes.url_helpers.article_url(to_param, host:  Rails.application.config.super_cool_mailer_host)}'/>"

    result
  end

  def pretty_excerpt
    result = excerpt.gsub(/\[(\w+)\]\(([^\)]+)\)/, '<a href=\2>\1</a>')
    result.inspect
  end

  private

  def set_published_at
    if publish == "1"
      self.update_attribute(:published_at, Time.zone.now)
    end
  end

  def parameterize_permalink
    self.permalink = self.permalink.parameterize if permalink.present?
  end

end
