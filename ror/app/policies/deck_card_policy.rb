class DeckCardPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    false
  end

  def new?
    false
  end

  def create?
    false
  end

  def edit?
    false
  end

  def update?
    user&.deck_cards.exists?(record.id)
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.joins(:deck, :journey).where(journey: { user_id: user&.id })
    end
  end
end
