class Dashboard

  def self.boxes_for(user)
    boxes = []

    # check the user's role to determine what boxes
    # they can have appear on their dashboard

    # My Comments
    boxes << {
      title: I18n.t("dashboard.boxes.comments.title"),
      link: [:comments, :my],
      content: I18n.t("dashboard.boxes.comments.content"),
      permission: [:create, Comment]
    }

    # My Inbox
    boxes << {
      # TODO: make the permissions match
      title: I18n.t("dashboard.boxes.inbox.title"),
      link: [:inbox, :my],
      content: I18n.t("dashboard.boxes.inbox.content"),
      permission: [:read, Comment]
    }

    # Edit My Profile
    boxes << {
      # TODO: make the permissions match
      title: I18n.t("dashboard.boxes.profile.title"),
      link: [:edit, :my, :profile],
      content: I18n.t("dashboard.boxes.profile.content"),
      permission: [:read, Article]
    }

    boxes
  end

  def self.model_name
    ActiveModel::Name.new(self)
  end
end