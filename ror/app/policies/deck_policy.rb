class DeckPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.decks.exists?(record.id)
  end

  def new?
    record.journey&.user == user
  end

  def create?
    new?
  end

  def edit?
    false
  end

  def update?
    record.journey&.user == user
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.joins(:journey).merge(Journey.accessible_by(user))
    end
  end
end
