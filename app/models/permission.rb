class Permission < ActiveRecord::Base
  belongs_to :role
  belongs_to :user

  # Note: We don't allow the user to be assigned the
  # same role twice (it wouldn't make sense!)
  validates :user_id, uniqueness: { scope: [:role_id] }
  validates :role_id, presence: true

end
