require 'rails_helper'

RSpec.describe 'analytics/index', type: :view do
    it 'displays a table with search queries and view counts' do
        assign(:user_queries, [Query.new(search_query: 'Test Query 1'), Query.new(search_query: 'Test Query 2')])
    
        render
    
        expect(rendered).to have_selector('.analytics-container')
        expect(rendered).to have_selector('table')
        expect(rendered).to have_selector('thead')
        expect(rendered).to have_selector('tbody')
    
        expect(rendered).to have_content('Search Query')
        expect(rendered).to have_content('View Count')
    
        expect(rendered).to have_content('Test Query 1')
        expect(rendered).to have_content('Test Query 2')
    end
end