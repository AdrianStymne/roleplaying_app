class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :content
      t.string :category
      t.text :tags, array: true, default: []

      t.timestamps
    end

    add_index :articles, :category
    add_index :articles, :tags, using: 'gin'
  end
end
