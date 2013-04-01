class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:calendar, :read, :tag_search], Article, ["published_at < ?", Time.zone.now] do |article|
      if article.published_at.present?
        article.published_at < Time.zone.now
      end
    end
    can :read, Comment
    can :create, User, permissions: { role: { key: 'commenter' } }
    can :confirm, User, confirm_token: user.confirm_token
    if user.is? :commenter
      can [:edit, :update], User, id: user.id
      # they can reply to and report any comment
      can [:like, :new_reply, :reply, :report], Comment
      # but they can only edit their own
      can [:create, :edit, :update], Comment, user_id: user.id
    end
    if user.is? :admin
      can :manage, :all
    end
  end
end
