class Language < ApplicationRecord
  has_many :lessons

  broadcasts_refreshes

  validates :code, presence: true, uniqueness: true,
    format: { with: /[a-z]{2}/,
    message: "must be a 2-letter lowercase code"
  }
  validates :name, presence: true, uniqueness: true

  def base_path
    "/#{code}"
  end
end
