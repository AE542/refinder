class ChatroomsController < ApplicationController
  def index
    @user = current_user
    @chatrooms = policy_scope(@user.chatrooms).order(created_at: :desc)
  end

  def show
    @chatroom = find_or_create_chatroom
    authorize @chatroom, policy_class: ChatroomPolicy
    @messages = @chatroom.messages
    @message = Message.new
    @message.user = current_user
    @other_user = User.find(@other_user_id) if @other_user_id
  end

  private

  def find_or_create_chatroom
    @user_id = current_user.id.to_i
    @other_user_id = params[:other_user_id].to_i if params[:other_user_id].present?
    @other_user = User.find(@other_user_id) if @other_user_id

    if @other_user_id
      chatroom = Chatroom.joins(:chatroom_users)
                          .where(chatrooms: { name: generate_chatroom_name(@user_id, @other_user_id) })
                          .where(chatroom_users: { user_id: [@user_id, @other_user_id] })
                          .group('chatrooms.id')
                          .having('COUNT(DISTINCT chatroom_users.user_id) = 2')
                          .first

      chatroom ||= Chatroom.create(name: generate_chatroom_name(@user_id, @other_user_id))
      create_chatroom_user(chatroom, @user_id)
      create_chatroom_user(chatroom, @other_user_id)
    else
      chatroom = Chatroom.find(params[:id])
    end

    chatroom
  end

  def generate_chatroom_name(user_id, other_user_id)
    [user_id, other_user_id].sort.join("_")
  end

  def create_chatroom_user(chatroom, user_id)
    chatroom.chatroom_users.find_or_create_by(user_id: user_id)
  end
end
