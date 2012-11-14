module ArticlesHelper
  def muted(resource, column, options={})
    if resource.try(column).blank?
      "muted"
    end
  end
end
