require 'rails_helper'

RSpec.describe Query, type: :model do
    context "validation" do
        it "validates presence of search_query" do
            query = Query.new 
            expect(query).not_to be_valid
            expect(query.errors[:search_query]).to include("can't be blank")
        end
    end

    context 'store_complete_queries' do
        it 'creates a new query with valid data' do
          expect {
            Query.store_complete_queries('Test query', '123.123.1.2')
          }.to change(Query, :count).by(1)
        end

        it 'does not create a query if conditions are not met' do
            Query.store_complete_queries('Test query', '123.123.1.2')
            expect {
              Query.store_complete_queries('Test query', '123.123.1.2')
            }.to_not change(Query, :count)
        end
    end

    context 'views_count' do
        it 'returns the count of views for a specific query and IP address' do
          Query.store_complete_queries('Test query', '123.123.1.2')
          count = Query.views_count('Test query', '123.123.1.2')
          expect(count).to eq(1)
        end
    
        it 'returns zero count for a query not found' do
          count = Query.views_count('Non-existent query', '123.123.1.2')
          expect(count).to eq(0)
        end
    end
end