class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])

    if @chatroom
      @message = @chatroom.messages.new(message_params)
      authorize @message
      @message.user = current_user

      if @message.save
        ChatroomChannel.broadcast_to(
          @chatroom,
          render_to_string(partial: "message", locals: {message: @message})
        )
        head :ok
      else
        redirect_to chatroom_path(@chatroom), alert: 'Failed to send message.'
      end
    else
      redirect_to root_path, alert: 'Chatroom or other user not found.'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
