class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.string :title, null: false
      t.integer :listing_type, null: false
      t.string :game, null: false
      t.text :description
      t.integer :status, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
