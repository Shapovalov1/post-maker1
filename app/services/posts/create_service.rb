module Posts
  class CreateService < Service
    class Input < BaseInput
      attribute :title, type: String
      attribute :post, type: String
      attribute :social_networks, array: true
      attribute :schedule_time, type: Date

      validates :title, presence: true
      validates :post, presence: true
      validates :schedule_time, presence: true
    end

    attr_reader :input, :post

    def perform

        if input[:schedule_time] > Date.today && input[:post].length <= 250 && input[:title].length <= 50
            for item in input[:social_networks] do
                if item.length != 0
                    SocialContent.create(title: input[:title], post: input[:post])
                    SocialContent.last.social_posts.create(schedule_time: input[:schedule_time], social_network: item)
                    SocialPost.create(schedule_time: input[:schedule_time], social_network: item)
                end
            end

        else
            errors.add(:base, 'Date is in the past or post length more then 250 symbols or title length more then 50 symbols')
        end


      # TODO:
      # 1. create SocialContent with title and post from input
      # 2. create as many related SocialPosts as many social_networks you have selected
      # 3. care about data consistency (Please read about ActiveRecord::Base.transaction)
      # 4. You must not create any SocialContent and SocialPosts:
      #   - if schedule_time in the past
      #   - if social_networks is empty array
      #   - if post length more then 250 symbols
      #   - if title length more then 50 symbols

    end
  end
end
