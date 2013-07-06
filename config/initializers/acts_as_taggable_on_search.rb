module ActsAsTaggableOn
  class Tag
    def self.tag_search(query)
      basic_search(query)
    end

    def published_taggings_count
      # sub-queries blow!
      unpublished_article_ids = Article.draft.pluck(:id)
      taggings.where("taggings.taggable_id NOT IN (?)", unpublished_article_ids).count
    end

    def total_taggings_count
      taggings.count
    end
  end
end
