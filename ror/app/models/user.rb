class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :journeys
  has_many :steps
  has_many :languages, through: :journeys
  has_many :lessons, through: :steps

  belongs_to :default_language, class_name: :Language

  validates :name, presence: true

  enum :role, {
    student: "student",
    teacher: "teacher",
    admin: "admin"
  }, prefix: :role_is
end
