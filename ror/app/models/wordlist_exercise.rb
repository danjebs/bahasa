class WordlistExercise < Exercise
  belongs_to :wordlist, optional: true

  has_many :words, class_name: :ExerciseWord, foreign_key: :exercise_id
end
