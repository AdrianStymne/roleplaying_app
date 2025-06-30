class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
