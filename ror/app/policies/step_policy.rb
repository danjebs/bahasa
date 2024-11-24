class StepPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    record.journey.accessible_by?(user)
  end

  def new?
    false
  end

  def create?
    false
  end

  def update?
    record.journey.editable_by?(user)
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
