class CreateQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :queries do |t|
      t.string :search_query
      t.string :ip_address

      t.timestamps
    end
  end
end
