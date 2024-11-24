class LessonPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    record.accessible_by?(user)
  end

  def new?
    record.course.editable_by?(user)
  end

  def create?
    new?
  end

  def edit?
    record.editable_by?(user)
  end

  def update?
    edit?
  end

  def destroy?
    record.editable_by?(user)
  end

  class Scope < Scope
    def resolve
      scope.accessible_by(user)
    end
  end
end
