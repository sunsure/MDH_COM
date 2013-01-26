class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:calendar, :read, :tag_search], Article, ["published_at < ?", Time.now] do |article|
      article.published_at < Time.now
    end
    can :read, Comment
    can :create, User, user: { role_ids: nil }
    can :confirm, User, confirm_token: user.confirm_token
    if user.is? :commenter
      can [:create, :edit, :update, :new_reply, :reply], Comment, user_id: user.id
    end
    if user.is? :admin
      can :manage, :all
    end
  end
end
