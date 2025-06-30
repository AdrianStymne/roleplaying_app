class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :player, null: false, foreign_key: true
      t.json :roll_data

      t.timestamps
    end

    add_index :messages, :created_at
  end
end
