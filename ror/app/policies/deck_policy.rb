class DeckPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.decks.exists?(record.id)
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def edit?
    false
  end

  def update?
    user&.decks.exists?(record.id)
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.joins(:journey).where(journey: { user_id: user&.id })
    end
  end
end
