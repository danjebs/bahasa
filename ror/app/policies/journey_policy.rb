class JourneyPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user&.journeys.exists?(record.id)
  end

  def new?
    false
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.where(user_id: user&.id)
    end
  end
end
