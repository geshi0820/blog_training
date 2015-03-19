class CreateFavorites < ActiveRecord::Migration

 def change
    create_table :favorites do |t|
      t.references :user
      t.references :article

      t.timestamps
    end
    add_index :favorites, [:user_id, :article_id], unique: true
  end
end