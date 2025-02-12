require "test_helper"

class ExerciseTest < ActiveSupport::TestCase
  def setup
    @exercise = Exercise.new(
      name: "Bench Press",
      category: "Chest",
      description: "Barbell chest press"
    )
  end

  test "should be valid" do
    assert @exercise.valid?
  end

  test "name should be present" do
    @exercise.name = ""
    assert_not @exercise.valid?
  end

  test "name should have minimum length" do
    @exercise.name = "a"
    assert_not @exercise.valid?
  end

  test "name should have maximum length" do
    @exercise.name = "a" * 51
    assert_not @exercise.valid?
  end

  test "name should be unique" do
    duplicate = exercises(:squat).dup
    assert_not duplicate.valid?
  end

  test "category should be present" do
    @exercise.category = ""
    assert_not @exercise.valid?
  end

  test "category should be in allowed list" do
    @exercise.category = "Invalid Category"
    assert_not @exercise.valid?

    ExerciseCategories::EXERCISE_CATEGORIES.each do |valid_category|
      @exercise.category = valid_category
      assert @exercise.valid?
    end
  end

  test "description should not exceed maximum length" do
    @exercise.description = "a" * 501
    assert_not @exercise.valid?
  end

  test "description can be blank" do
    @exercise.description = ""
    assert @exercise.valid?
  end

  test "name should be capitalized before save" do
    @exercise.name = "bench press"
    @exercise.save
    assert_equal "Bench Press", @exercise.name
  end

  test "should reject duplicate names regardless of case" do
    @exercise.save
    duplicate_exercise = Exercise.new(
      name: @exercise.name.downcase,
      category: "Chest"
    )
    assert_not duplicate_exercise.valid?
  end
end
