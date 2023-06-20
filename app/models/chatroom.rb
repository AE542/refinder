class Chatroom < ApplicationRecord
  has_many :chatroom_users
  has_many :users, through: :chatroom_users
  has_many :messages





  def other_user_email(current_user)
    other_user = users.joins(:chatroom_users).where.not(id: current_user.id).first
    other_user&.email
  end



end
