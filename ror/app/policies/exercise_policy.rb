class ExercisePolicy < ApplicationPolicy
  def index?
    user&.role_is_admin?
  end

  def show?
    true
    # user&.languages.exists?(record.id)
  end

  def new?
    user&.role_is_admin?
  end

  def create?
    user&.role_is_admin?
  end

  def edit?
    user&.role_is_admin?
  end

  def update?
    user&.role_is_admin?
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      if user&.role_is_admin?
        scope.all
      # elsif user&.role_is_teacher?
      #   scope.where(organisation: user.organisation)
      else
        scope.none
      end
    end
  end
end
