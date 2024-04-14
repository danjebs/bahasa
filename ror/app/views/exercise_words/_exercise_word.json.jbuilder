json.extract! exercise_word, :id, :exercise_id, :word, :translation, :position, :created_at, :updated_at
json.url exercise_word_url(exercise_word, format: :json)
