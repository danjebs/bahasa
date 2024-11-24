class PhrasePolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    record.exercise.lesson.accessible_by?(user)
  end

  def new?
    record.exercise.lesson.editable_by?(user)
  end

  def create?
    new?
  end

  def edit?
    record.exercise.lesson.editable_by?(user)
  end

  def update?
    edit?
  end

  def destroy?
    record.exercise.lesson.editable_by?(user)
  end

  class Scope < Scope
    def resolve
      scope.joins(exercise: :lesson).merge(Lesson.accessible_by(user))
    end
  end
end
