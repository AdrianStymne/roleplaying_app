class MessagesController < ApplicationController
  def index
    @messages = Message.recent.includes(:player)
    @message = Message.new
    @players = Player.all
    @current_player = current_player
  end

  def set_current_player
    if params[:player_id].present?
      session[:current_player_id] = params[:player_id]
    end
    redirect_to messages_path
  end

  def create
    if current_player.nil?
      redirect_to messages_path, alert: "Please select a player first"
      return
    end

    @message = Message.new(message_params.merge(player_id: current_player.id))

    if @message.save
      redirect_to messages_path
    else
      @messages = Message.recent.includes(:player)
      @players = Player.all
      @current_player = current_player
      render :index
    end
  end

  def roll_dice
    if current_player.nil?
      redirect_to messages_path, alert: "Please select a player first"
      return
    end

    @message = Message.new(player_id: current_player.id)

    if valid_dice_type?
      @message.roll_dice(dice_params[:dice_type], dice_params[:count], dice_params[:modifier])

      if @message.save
        redirect_to messages_path
      else
        redirect_to messages_path, alert: "Failed to roll dice"
      end
    else
      redirect_to messages_path, alert: "Please select valid dice"
    end
  end

  private

  def current_player
    @current_player ||= Player.find_by(id: session[:current_player_id]) if session[:current_player_id]
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def dice_params
    params.permit(:dice_type, :count, :modifier).tap do |p|
      p[:count] = (p[:count]&.to_i || 1).clamp(1, 10)
      p[:modifier] = p[:modifier]&.to_i || 0
      p[:dice_type] = p[:dice_type]&.to_i
    end
  end

  def valid_dice_type?
    [ 4, 6, 8, 10, 12, 20 ].include?(dice_params[:dice_type])
  end
end
