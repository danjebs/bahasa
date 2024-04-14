class Wordlist < ApplicationRecord
  belongs_to :language

  has_many :wordlist_exercises

  validates :name, presence: true, uniqueness: { scope: :language_id }
  validates :slug, presence: true, uniqueness: { scope: :language_id }

  before_validation :set_slug, on: [:create, :update]

  def set_slug
    self.slug = self.name.parameterize
  end
end
