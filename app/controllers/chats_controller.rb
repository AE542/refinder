class ChatsController < ApplicationController
  before_action :authenticate_user!

  def show
    @chatroom = Chat
end
