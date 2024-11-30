class Course < ApplicationRecord
  resourcify

  belongs_to :language
  belongs_to :creator, class_name: "User"
  has_many :lessons
  has_many :journeys

  after_create :add_creator_as_owner

  scope :accessible_by, -> (user) {
    return none if user.nil?

    joins(:roles).where(roles: { id: user.roles.select(:id) })
  }

  def accessible_by?(user)
    user.has_role?(:owner, self) || user.has_role?(:student, self)
  end

  def editable_by?(user)
    user.has_role?(:owner, self)
  end

  protected

  def add_creator_as_owner
    creator.add_role(:owner, self)
  end
end
