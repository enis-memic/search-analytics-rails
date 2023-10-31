class Query < ApplicationRecord
    validates :search_query, presence: true
  
    def update_or_save!
      if query_already_searched? && !candidate_for_update?
        duplicate_query.increment!(:views_count) 
      else
        candidate_for_update? ? latest_query.update!(search_query: search_query) : save!
      end
    end

    private

    def latest_query
      @latest_query ||= self.class.where(ip_address: ip_address).last
    end

    def duplicate_query
      @duplicate_query ||= self.class.find_by(ip_address: ip_address, search_query: search_query)
    end

    def candidate_for_update?
      return false unless latest_query
      return true if in_search_session? && search_query.include?(latest_query.search_query)

      return false
    end

    def in_search_session?
      latest_query.updated_at > 15.seconds.ago
    end

    def query_already_searched?
      return false unless duplicate_query 
      return true if !in_search_session?
      return true if !search_query.include?(latest_query.search_query) && in_search_session?
 
      false
    end
  end