class Role < ActiveRecord::Base
  has_many :permissions
  has_many :users, through: :permissions

  validates :name,
    uniqueness: { case_sensitive: false },
    presence: true
  validates :key,
    uniqueness: { case_sensitive: false },
    presence: true

  def self.get(key)
    where(key: key).first
  end

end
