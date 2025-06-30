class CharacterSheet < ApplicationRecord
  belongs_to :player

  # Virtual attributes for Rails forms - Weapons
  def weapons_attributes=(attributes)
    valid_weapons = attributes.values.reject { |attr| attr.values.all?(&:blank?) }
    self.weapons_json = valid_weapons.to_json
  end

  def weapons_attributes
    weapons.each_with_index.map { |weapon, index| [index, weapon] }.to_h
  end

  def weapons
    weapons_json.present? ? JSON.parse(weapons_json) : []
  rescue JSON::ParserError
    []
  end

  # Virtual attributes for Rails forms - Armor
  def armor_attributes=(attributes)
    valid_armor = attributes.values.reject { |attr| attr.values.all?(&:blank?) }
    self.armor_json = valid_armor.to_json
  end

  def armor_attributes
    armor.each_with_index.map { |armor_piece, index| [index, armor_piece] }.to_h
  end

  def armor
    armor_json.present? ? JSON.parse(armor_json) : []
  rescue JSON::ParserError
    []
  end

  # Virtual attributes for Rails forms - Foci
  def foci_attributes=(attributes)
    valid_foci = attributes.values.reject { |attr| attr.values.all?(&:blank?) }
    self.foci_json = valid_foci.to_json
  end

  def foci_attributes
    foci.each_with_index.map { |focus, index| [index, focus] }.to_h
  end

  def foci
    foci_json.present? ? JSON.parse(foci_json) : []
  rescue JSON::ParserError
    []
  end

  # Virtual attributes for Rails forms - Goals
  def goals_attributes=(attributes)
    valid_goals = attributes.values.reject { |attr| attr.values.all?(&:blank?) }
    self.goals_json = valid_goals.to_json
  end

  def goals_attributes
    goals.each_with_index.map { |goal, index| [index, goal] }.to_h
  end

  def goals
    goals_json.present? ? JSON.parse(goals_json) : []
  rescue JSON::ParserError
    []
  end

  # Skills accessor
  def skills
    skills_json.present? ? skills_json : default_skills
  end

  def skills=(value)
    self.skills_json = value
  end

  # Simple accessors for other JSON fields
  def gear
    gear_json.present? ? JSON.parse(gear_json) : []
  rescue JSON::ParserError
    []
  end

  def gear=(value)
    self.gear_json = value.is_a?(Array) ? value.to_json : value
  end

def psi_powers_attributes=(attributes)
  valid_powers = attributes.values.reject { |attr| attr.values.all?(&:blank?) }
  self.psi_powers_json = valid_powers.to_json
end

def psi_powers_attributes
  psi_powers.each_with_index.map { |power, index| [index, power] }.to_h
end

def psi_powers
  psi_powers_json.present? ? JSON.parse(psi_powers_json) : []
rescue JSON::ParserError
  []
end

def psi_powers=(value)
  self.psi_powers_json = value.is_a?(Array) ? value.to_json : value
end

  private

  def default_skills
    {
      "Administer" => "-1", "Connect" => "-1", "Exert" => "-1", "Fix" => "-1",
      "Heal" => "-1", "Know" => "-1", "Lead" => "-1", "Notice" => "-1",
      "Perform" => "-1", "Pilot" => "-1", "Plot" => "-1", "Program" => "-1",
      "Punch" => "-1", "Shoot" => "-1", "Sneak" => "-1", "Stab" => "-1",
      "Survive" => "-1", "Talk" => "-1", "Trade" => "-1", "Work" => "-1",
      "Biopsionics" => "-1", "Metapsionics" => "-1", "Precognition" => "-1",
      "Telekinesis" => "-1", "Telepathy" => "-1", "Teleportation" => "-1"
    }
  end
end