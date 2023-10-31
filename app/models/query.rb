class Query < ApplicationRecord
    validates :search_query, presence: true
  
    def self.store_complete_queries(query, ip_address)
      return if should_discard_query?(query, ip_address)
      
      create(search_query: query, ip_address: ip_address)
    end

    def self.views_count(search_query, ip_address)
      where(ip_address: ip_address, search_query: search_query).count
    end
  
    private
  
    def self.should_discard_query?(query, ip_address)
      last_query = where(ip_address: ip_address).last
  
      return false if last_query.nil? || last_query.updated_at < 15.seconds.ago
      return true if last_query.search_query.include?(query)
  
      if query.include?(last_query.search_query)
        last_query.update(search_query: query)
        return true
      end
  
      false
    end
  end