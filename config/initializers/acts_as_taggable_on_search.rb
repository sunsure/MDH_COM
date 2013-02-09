module ActsAsTaggableOn
  class Tag
    def self.tag_search(query)
      basic_search(query)
    end
  end
end