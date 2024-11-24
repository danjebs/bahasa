class Course < ApplicationRecord
  resourcify

  belongs_to :language
  belongs_to :creator, class_name: "User"
  has_many :lessons
  has_many :journeys

  after_create :add_creator_as_owner

  def editable_by?(user)
    user.has_role?(:owner, self)
  end

  protected

  def add_creator_as_owner
    creator.add_role(:owner, self)
  end
end
