class Article < ActiveRecord::Base
  belongs_to :user

  attr_accessor :publish

  validates :title, presence: true
  validates :content, presence: true

  before_validation :set_published_at

  scope :draft, where(Article.arel_table[:published_at].eq(nil))
  scope :published, where(Article.arel_table[:published_at].not_eq(nil))

  private

  def set_published_at
    if publish == "1"
      self.update_attribute(:published_at, Time.zone.now)
    end
  end

end
