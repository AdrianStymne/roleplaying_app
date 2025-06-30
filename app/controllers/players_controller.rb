class PlayersController < ApplicationController
  before_action :set_player, only: [ :show, :edit, :update, :destroy ]

  def index
    @players = Player.all.order(:name)
  end

  def show
    @recent_messages = @player.messages.recent.limit(10)
    # Future: @character_sheets = @player.character_sheets
    # Future: @stats = @player.calculate_stats
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to @player, notice: "Player was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @player.update(player_params)
      redirect_to @player, notice: "Player was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @player.destroy
    redirect_to players_path, notice: "Player was successfully removed."
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :active)
  end
end
