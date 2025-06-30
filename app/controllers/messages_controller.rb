class MessagesController < ApplicationController
  def index
    @messages = Message.recent.includes(:player)
    @message = Message.new
    @players = Player.all
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to messages_path
    else
      @messages = Message.recent.includes(:player)
      @players = Player.all
      render :index
    end
  end

  def roll_dice
    @message = Message.new(player_id: dice_params[:player_id])

    if @message.player_id.present? && valid_dice_type?
      @message.roll_dice(dice_params[:dice_type], dice_params[:count], dice_params[:modifier])

      if @message.save
        redirect_to messages_path
      else
        redirect_to messages_path, alert: "Failed to roll dice"
      end
    else
      redirect_to messages_path, alert: "Please select a player and valid dice"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :player_id)
  end

  def dice_params
    params.permit(:player_id, :dice_type, :count, :modifier).tap do |p|
      p[:count] = (p[:count]&.to_i || 1).clamp(1, 10)
      p[:modifier] = p[:modifier]&.to_i || 0
      p[:dice_type] = p[:dice_type]&.to_i
    end
  end

  def valid_dice_type?
    [ 4, 6, 8, 10, 12, 20 ].include?(dice_params[:dice_type])
  end
end
