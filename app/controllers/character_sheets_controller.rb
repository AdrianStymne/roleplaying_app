class CharacterSheetsController < ApplicationController
  before_action :set_player
  before_action :set_character_sheet, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @character_sheet.update(character_sheet_params)
      redirect_to [@player, @character_sheet], notice: "Character sheet updated successfully."
    else
      render :edit
    end
  end

  def new
    @character_sheet = @player.build_character_sheet
  end

  def create
    @character_sheet = @player.build_character_sheet(character_sheet_params)
    
    if @character_sheet.save
      redirect_to [@player, @character_sheet], notice: "Character sheet created successfully."
    else
      render :new
    end
  end

  private

  def set_player
    @player = Player.find(params[:player_id])
  end

  def set_character_sheet
    @character_sheet = @player.character_sheet || @player.build_character_sheet
  end

  def character_sheet_params
    params.require(:character_sheet).permit(
      :name, :character_class, :species, :gender, :background, :homeworld, :employer,
      :initiative, :base_attack_bonus, :full_attack_bonus, :active_ac,
      :level, :xp, :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma,
      :system_strain, :system_strain_perm, :hp_max, :hp_curr, :ab, :st_phys, :st_evade, :st_ment,
      :cyberware, :credits, :credits_owed, :effort_curr, :effort_max, :skill_points, :notes, :tags,
      skills_json: {},
      weapons_attributes: [:name, :damage, :range, :notes],
      armor_attributes: [:name, :ac, :notes],
      foci_attributes: [:name, :level, :description],
      goals_attributes: [:goal, :notes],
      psi_powers_attributes: [:name, :description]
    )
  end
end