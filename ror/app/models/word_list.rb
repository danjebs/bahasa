class WordList < Exercise
  has_many :words, class_name: :ExerciseWord, foreign_key: :exercise_id
end
