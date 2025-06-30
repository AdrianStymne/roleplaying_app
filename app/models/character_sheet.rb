class CharacterSheet < ApplicationRecord
  belongs_to :player

  # JSON field accessors with defaults
  def weapons
    weapons_json || []
  end

  def weapons=(value)
    self.weapons_json = value
  end

  def armor
    armor_json || []
  end

  def armor=(value)
    self.armor_json = value
  end

  def gear
    gear_json || []
  end

  def gear=(value)
    self.gear_json = value
  end

  def skills
    skills_json || default_skills
  end

  def skills=(value)
    self.skills_json = value
  end

  def foci
    foci_json || []
  end

  def foci=(value)
    self.foci_json = value
  end

  def psi_powers
    psi_powers_json || []
  end

  def psi_powers=(value)
    self.psi_powers_json = value
  end

  def goals
    goals_json || []
  end

  def goals=(value)
    self.goals_json = value
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
