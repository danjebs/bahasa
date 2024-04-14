class User < ApplicationRecord
  validates :name, presence: true

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  enum :role, {
    student: "student",
    teacher: "teacher",
    admin: "admin"
  }, prefix: :role_is
end
