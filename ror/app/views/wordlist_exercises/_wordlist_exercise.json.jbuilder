json.extract! wordlist_exercise, :id, :language_id, :title, :type, :position, :created_at, :updated_at
json.url exercise_url(wordlist_exercise, format: :json)
