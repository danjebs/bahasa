class WordList < Exercise
  has_many :words, class_name: :Word, foreign_key: :exercise_id, dependent: :destroy
end
