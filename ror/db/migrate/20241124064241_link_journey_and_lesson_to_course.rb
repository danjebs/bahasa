class LinkJourneyAndLessonToCourse < ActiveRecord::Migration[7.2]
  def up
    # link journeys to courses
    add_reference :journeys, :course, foreign_key: true, null: true

    Journey.all.each do |journey|
      course = Course.create!(
        language_id: journey.language_id,
        creator_id: journey.user_id,
        name: "Learn #{Language.find(journey.language_id).name} with #{journey.user.name}"
      )

      journey.update!(course_id: course.id)
    end

    remove_column :journeys, :language_id
    change_column_null :journeys, :course_id, false

    # link lessons to courses
    add_reference :lessons, :course, foreign_key: true, null: true

    Lesson.all.each do |lesson|
      course = Course.find_by(language_id: lesson.language_id)
      lesson.update!(course_id: course.id)
    end

    remove_column :lessons, :language_id
    change_column_null :lessons, :course_id, false
  end

  def down
    add_reference :journeys, :language, foreign_key: true, null: true

    Journey.all.each do |journey|
      journey.update!(language_id: journey.course.language_id)
    end

    remove_reference :journeys, :course, foreign_key: true
    change_column_null :journeys, :language_id, false

    add_reference :lessons, :language, foreign_key: true, null: true

    Lesson.all.each do |lesson|
      lesson.update!(language_id: lesson.course.language_id)
    end

    remove_reference :lessons, :course, foreign_key: true
    change_column_null :lessons, :language_id, false
  end
end
