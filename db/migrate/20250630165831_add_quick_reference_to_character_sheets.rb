class AddQuickReferenceToCharacterSheets < ActiveRecord::Migration[8.0]
  def change
    add_column :character_sheets, :initiative, :string
    add_column :character_sheets, :base_attack_bonus, :string
    add_column :character_sheets, :full_attack_bonus, :string
    add_column :character_sheets, :active_ac, :string
  end
end
