class CharacterSheetsController < ApplicationController
  before_action :set_player
  before_action :set_character_sheet, only: [ :show, :edit, :update ]

  def show
  end

  def edit
  end

  def update
    if @character_sheet.update(character_sheet_params)
      redirect_to [ @player, @character_sheet ], notice: "Character sheet updated successfully."
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
      redirect_to [ @player, @character_sheet ], notice: "Character sheet created successfully."
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
      # Basic info
      :name, :character_class, :partial, :species, :gender, :employer,
      :homeworld, :background, :level, :xp,

      # Core stats
      :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma,

      # Health & combat
      :system_strain, :system_strain_perm, :hp_max, :hp_curr, :ab,
      :st_phys, :st_evade, :st_ment,

      # Equipment & economy
      :cyberware, :credits, :credits_owed,

      # Skills & Psionics
      :skill_points, :effort_curr, :effort_max,

      # Miscellaneous
      :notes, :jsondata, :tags,

      # JSON fields - permit nested parameters
      skills: {},
      weapons: [ :ready, :name, :damage, :range, :ammo, :mods, :ab ],
      armor: [ :ready, :name, :ac, :mods ],
      gear: [ :ready, :name, :enc ],
      goals: [ :name, :xp ],
      foci: [ :name, :level, :desc ],
      psi_powers: [ :name, :level, :desc ]
    )
  end
end
