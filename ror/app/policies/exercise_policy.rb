class ExercisePolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    record.lesson.accessible_by?(user)
  end

  def new?
    record.lesson.editable_by?(user)
  end

  def create?
    new?
  end

  def edit?
    record.lesson.editable_by?(user)
  end

  def update?
    edit?
  end

  def destroy?
    record.lesson.editable_by?(user)
  end

  class Scope < Scope
    def resolve
      scope.joins(:lesson).merge(Lesson.accessible_by(user))
    end
  end
end
