class ExerciseWordsController < ApplicationController
  before_action :set_exercise_word, only: [:edit, :update, :destroy]

  def new
    authorize ExerciseWord

    @exercise_word = ExerciseWord.new(exercise_id: params[:exercise_id])

    render Words::WordNew.new(exercise_word: @exercise_word)
  end

  def edit
    authorize @exercise_word

    render Words::WordEdit.new(exercise_word: @exercise_word)
  end

  def create
    authorize ExerciseWord

    @exercise_word = ExerciseWord.new(exercise_word_params)

    respond_to do |format|
      if @exercise_word.save
        format.turbo_stream {
          turbo_stream.append(
            :exercise_words,
            Lessons::LessonShow.new(lesson: @exercise_word.exercise.lesson)
          )
        }
        format.html {
          render Lessons::LessonShow.new(lesson: @exercise_word.exercise.lesson),
          notice: "Exercise word was successfully created."
        }
      else
        format.html {
          render(
            Words::WordNew.new(exercise_word: @exercise_word),
            status: :unprocessable_entity
          )
        }
      end
    end
  end

  def update
    authorize @exercise_word


    if exercise_word_params[:position].present? && exercise_word_params[:position] != @exercise_word.position
      @exercise_word.insert_at(exercise_word_params[:position])
    end

    respond_to do |format|
      if @exercise_word.update(exercise_word_params)
        format.html {
          render Words::WordListing.new(exercise_word: @exercise_word),
          notice: "Exercise word was successfully updated."
        }
      else
        format.html {
          render Words::WordEdit.new(exercise_word: @exercise_word),
          status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    authorize @exercise_word

    @exercise_word.destroy!

    respond_to do |format|
      format.turbo_stream { turbo_stream.remove(:exercise_words) }
      format.html {
        render Lessons::LessonShow(lesson: @exercise_word.exercise.lesson),
        notice: "Exercise word was successfully destroyed."
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_word
      @exercise_word = ExerciseWord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exercise_word_params
      params.require(:exercise_word).permit(:exercise_id, :word, :translation, :position)
    end
end
