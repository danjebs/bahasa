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
    record.editable_by?(user)
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.joins(deck: :journey).merge(Journey.accessible_by(user))
    end
  end
end
