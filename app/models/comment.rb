class Comment < ActiveRecord::Base
  belongs_to :article, counter_cache: true
  belongs_to :user

  has_ancestry

  # Newest are at the bottom
  default_scope order("created_at ASC")

  validates :content, presence: true
  validates :title, presence: true

  def user_name
    user.try(:name) if user.present?
  end

end
