module Posts
  class FeedFilter < BaseFilter
    def perform

        if input[:search_text]
            @a = SocialContent.where("title LIKE ?", "%#{input[:search_text]}%").or(SocialContent.where("post LIKE ?", "%#{input[:search_text]}%"))
        else
            @a = base_scope
        end

        if input[:social_networks]
            @b = SocialContent.joins(:social_posts).where(social_posts: { social_network: input[:social_networks] } )
            @b = @a & @b
        else
            @b = @a
        end

        #if input[:date_from]
            
            #@c = SocialContent.joins(:social_posts).where(social_posts: { schedule_time: input[:date_from] } )
            #@c = @b & @c
        #else
            #@c = @b
        #end

      
      # TODO:
      # 1. apply all filters that come from input
      #   - filter by title/post contains search_text
      #   - filter by social networks
      #   - filter by date range (date_from, date_to)
      #base_scope
      
    end

    private

    # NOTE: this method can be modified
    def base_scope
        SocialContent.all.includes(:social_posts)
    end
  end
end
