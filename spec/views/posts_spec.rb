require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  before do
    assign(:posts, [])
    render
  end
  it 'renders the search form' do
    expect(rendered).to have_selector('form.search-form')
    expect(rendered).to have_field('query')
    expect(rendered).to have_button('Search')
  end
end