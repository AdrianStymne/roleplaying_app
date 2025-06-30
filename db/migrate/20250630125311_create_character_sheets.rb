class CreateCharacterSheets < ActiveRecord::Migration[8.0]
  def change
    create_table :character_sheets do |t|
      t.references :player, null: false, foreign_key: true

      # Basic Character Info
      t.string :name
      t.string :character_class
      t.string :partial
      t.string :species
      t.string :gender
      t.string :employer
      t.string :homeworld
      t.string :background
      t.integer :level
      t.string :xp

      # Core Stats
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma

      # Health & Combat
      t.string :system_strain
      t.string :system_strain_perm
      t.string :hp_max
      t.string :hp_curr
      t.string :ab
      t.string :st_phys
      t.string :st_evade
      t.string :st_ment

      # Equipment & Economy
      t.text :cyberware
      t.string :credits
      t.string :credits_owed

      # Psionics
      t.string :effort_curr
      t.string :effort_max
      t.string :skill_points

      # Miscellaneous
      t.text :notes
      t.text :jsondata
      t.string :tags

      # JSON columns for repetitive data
      t.json :weapons_json
      t.json :armor_json
      t.json :gear_json
      t.json :skills_json
      t.json :foci_json
      t.json :psi_powers_json
      t.json :goals_json

      t.timestamps
    end
  end
end
