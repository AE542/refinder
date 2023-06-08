class ItemPolicy < ApplicationPolicy
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
    true # Allow all users to view items
  end

  def show?
    true # Allow all users to view a specific item
  end

  def new?
    return create? # Allow all users to view a specific item
  end

  def create?
    true # Allow all users to create items
  end

  def edit?
    return update? # Allow all users to create items
  end

  def update?
    record.user == user # Allow updating only if the item is owned by the user
  end

  def destroy?
    record.user == user # Allow deleting only if the item is owned by the user
  end

  def my_items?
    true
  end
end
