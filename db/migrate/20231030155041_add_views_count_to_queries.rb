class AddViewsCountToQueries < ActiveRecord::Migration[7.0]
  def change
    add_column :queries, :views_count, :integer
  end
end