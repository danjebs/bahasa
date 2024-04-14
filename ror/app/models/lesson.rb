class Lesson < ApplicationRecord
  belongs_to :language

  has_many :exercises
end
