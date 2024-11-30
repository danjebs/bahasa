class JourneyPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    record.accessible_by?(user)
  end

  def new?
    false
  end

  def create?
    user.present?
  end

  def update?
    false
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.accessible_by(user)
    end
  end
end
