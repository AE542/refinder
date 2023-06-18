class MessagePolicy < ApplicationPolicy
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


  def index?
    true
  end

  def show?
    true
  end

  def new?
    return create?
  end

  def create?
    true
  end

end
