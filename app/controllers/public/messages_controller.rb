class Public::MessagesController < ApplicationController
  before_action :authenticate_member!
  def create
    message = Message.new(message_params)
    message.member_id = current_member.id
    if message.save
      redirect_to room_path(message.room)
    else
      redirect_back(fallback_location: root_path) #直前のページにリダイレクト
    end
  end

  private

  def message_params
      params.require(:message).permit(:room_id, :message)
    end
end
