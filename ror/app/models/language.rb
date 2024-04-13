class Language < ApplicationRecord
  validates :code, presence: true, uniqueness: true,
    format: { with: /[a-z]{2}/,
    message: "must be a 2-letter lowercase code"
  }
  validates :name, presence: true, uniqueness: true
end
