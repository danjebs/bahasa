class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :journeys
  has_many :steps
  has_many :lessons, through: :steps
  has_many :languages, through: :journeys
  has_many :decks, through: :journeys
  has_many :deck_cards, through: :decks
  has_many :card_proficiencies, through: :journeys
  has_many :cards, through: :decks

  belongs_to :default_language, class_name: :Language, optional: true

  validates :name, presence: true

  enum :role, {
    student: "student",
    teacher: "teacher",
    admin: "admin"
  }, prefix: :role_is
end
