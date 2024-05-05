class PhraseList < Exercise
  has_many :phrases, foreign_key: :exercise_id
end
