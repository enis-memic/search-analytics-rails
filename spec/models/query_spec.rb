require 'rails_helper'

RSpec.describe Query, type: :model do
  it 'validates presence of search_query' do
    query = Query.new
    query.valid?
    expect(query.errors[:search_query]).to include("can't be blank")
  end

  describe '#process!' do
    context 'when query has not been searched before' do
      it 'creates a new query' do
        query = Query.new(search_query: 'Test query', ip_address: '123.123.1.2')
        expect { query.process! }.to change { Query.count }.by(1)
      end
    end

    context 'when query has been searched before' do
      before do
        Query.create(search_query: 'Test query', ip_address: '123.123.1.2')
      end

      it 'updates the existing query if conditions are met' do
        query = Query.new(search_query: 'Test query', ip_address: '123.123.1.2')
        expect { query.process! }.not_to change { Query.count }
        expect(Query.last.search_query).to eq('Test query')
      end
    end
  end
end