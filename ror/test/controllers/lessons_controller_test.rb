require "test_helper"

class LessonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = users(:simba)
    @teacher = users(:teacher_id)

    @other_student = users(:bean)
    @other_teacher = users(:teacher_de)

    @lesson = lessons(:lesson_greetings_id)

    sign_in @student
  end

  test "should get index for student" do
    get lessons_url(lang: @lesson.language.code)
    assert_response :success

    @student.journeys.find_by(language_id: @lesson.language_id).lessons.each do |lesson|
      assert_select "div##{dom_id(lesson, :row)}"
    end

    @student.journeys.where.not(language_id: @lesson.language_id).each do |journey|
      journey.lessons.each do |lesson|
        assert_select "div##{dom_id(lesson, :row)}", count: 0
      end
    end

    @other_student.journeys.each do |journey|
      journey.lessons.each do |lesson|
        assert_select "div##{dom_id(lesson, :row)}", count: 0
      end
    end
  end

  test "should get index for teacher" do
    sign_in @teacher
    get lessons_url(lang: @lesson.language.code)
    assert_response :success

    @teacher.students.each do |student|
      student.journeys.find_by(language_id: @lesson.language_id).lessons.each do |lesson|
        assert_select "div##{dom_id(lesson, :row)}"
      end
    end

    @teacher.students.each do |student|
      student.journeys.where.not(language_id: @lesson.language_id).each do |journey|
        journey.lessons.each do |lesson|
          assert_select "div##{dom_id(lesson, :row)}", count: 0
        end
      end
    end

    @other_teacher.students.each do |student|
      student.journeys.each do |journey|
        journey.lessons.each do |lesson|
          assert_select "div##{dom_id(lesson, :row)}", count: 0
        end
      end
    end
  end

  test "should get new for student with existing journey" do
    get new_lesson_url(lang: @lesson.language.code)
    assert_response :success
  end

  test "should not get new for student without existing journey" do
    sign_in @other_student
    get new_lesson_url(lang: @lesson.language.code)
    assert_response :forbidden
  end

  test "should show lesson for student with access" do
    get lesson_url(@lesson, lang: @lesson.language.code)
    assert_response :success
  end

  test "should show lesson for teacher with access" do
    sign_in @teacher
    get lesson_url(@lesson, lang: @lesson.language.code)
    assert_response :success
  end

  test "should not show lesson for student without access" do
    sign_in @other_student
    get lesson_url(@lesson, lang: @lesson.language.code)
    assert_response :forbidden
  end

  test "should not show lesson for teacher without access" do
    sign_in @other_teacher
    get lesson_url(@lesson, lang: @lesson.language.code)
    assert_response :forbidden
  end

  test "should update lesson if student has access" do
    patch lesson_url(@lesson, lang: @lesson.language.code), params: { lesson: { title: "Updated Title", position: 2 } }
    assert_redirected_to lesson_url(@lesson, lang: @lesson.language.code)

    @lesson.reload

    assert_equal "Updated Title", @lesson.title
    assert_equal 2, @lesson.position
  end

  test "should update lesson if teacher has access" do
    sign_in @teacher
    patch lesson_url(@lesson, lang: @lesson.language.code), params: { lesson: { title: "Updated Title", position: 2 } }
    assert_redirected_to lesson_url(@lesson, lang: @lesson.language.code)
    @lesson.reload
    assert_equal "Updated Title", @lesson.title
    assert_equal 2, @lesson.position
  end

  test "should only allow updating lesson title and position" do
    patch lesson_url(@lesson, lang: @lesson.language.code), params: { lesson: { title: "Updated Title", position: 2, other_attribute: "Invalid" } }
    assert_redirected_to lesson_url(@lesson, lang: @lesson.language.code)
    @lesson.reload
    assert_equal "Updated Title", @lesson.title
    assert_equal 2, @lesson.position
    assert_not_equal "Invalid", @lesson.other_attribute
  end

  test "should not destroy lesson for student with access" do
    assert_no_difference("Lesson.count") do
      delete lesson_url(@lesson, lang: @lesson.language.code)
    end
    assert_response :forbidden
  end

  test "should not destroy lesson for teacher with access" do
    sign_in @teacher
    assert_no_difference("Lesson.count") do
      delete lesson_url(@lesson, lang: @lesson.language.code)
    end
    assert_response :forbidden
  end

  test "should handle invalid lesson creation" do
    sign_in @student
    assert_no_difference("Lesson.count") do
      post lessons_url(lang: @lesson.language.code), params: { lesson: { title: "", position: nil } }
    end
    assert_response :unprocessable_entity
  end

  test "should handle no lessons for student" do
    sign_in @other_student
    get lessons_url(lang: @lesson.language.code)
    assert_response :success
    assert_select "div.lesson", count: 0
  end

  test "should handle no lessons for teacher" do
    teacher_without_students = users(:teacher_without_students)
    sign_in teacher_without_students
    get lessons_url(lang: @lesson.language.code)
    assert_response :success
    assert_select "div.lesson", count: 0
  end

  test "should handle non-existent lesson access" do
    get lesson_url(id: -1, lang: @lesson.language.code)
    assert_redirected_to root_url
  end
end
