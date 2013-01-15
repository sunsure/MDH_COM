module ArticlesHelper
  def muted(resource, column, options={})
    if resource.try(column).blank?
      "muted"
    end
  end

  def active(param_name, param_value, options={})

    # We're checking to make sure that parameter is NOT present
    if options[:missing].present?
      return 'active' unless params[param_name].present?
    end

    # Is the parameter present and equal to what I want
    if params[param_name].present? && params[param_name] == param_value
      return 'active'
    end

    # nothing for you
    nil
  end

  def article_per_page_options
    [["10 per page", '10'], ["25 per page", '25'], ["50 per page", '50'], ["100 per page", '100']]
  end
end
