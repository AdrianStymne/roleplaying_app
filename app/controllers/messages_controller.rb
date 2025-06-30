class MessagesController < ApplicationController
  def index
    @messages = Message.includes(:player).recent.limit(100).reverse
    @message = Message.new
    @players = Player.active
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      ActionCable.server.broadcast(
        "feed_channel",
        {
          message: render_message(@message),
          player_name: @message.player.name
        }
      )
      head :ok
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :player_id, :roll_data)
  end

  def render_message(message)
    ApplicationController.renderer.render(
      partial: "messages/message",
      locals: { message: message }
    )
  end
end
