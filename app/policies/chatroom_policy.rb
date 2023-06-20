class ChatroomPolicy < ApplicationPolicy
  # NOTE: Be explicit about which records you allow access to!
  # def resolve
  #   scope.all
  # end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    true # Allow all users to view a specific item
  end

end
