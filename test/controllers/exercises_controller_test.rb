require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise = exercises(:deadlift)
    @exercise_params = {
      name: "Bench Press",
      category: "Chest",
      description: "A chest exercise performed with a barbell on a bench."
    }
  end

  # Authentication tests
  test "should redirect unauthenticated user to login page" do
    get exercises_path
    assert_redirected_to new_user_session_path
    
    get exercise_path(@exercise)
    assert_redirected_to new_user_session_path
    
    get new_exercise_path
    assert_redirected_to new_user_session_path
    
    get edit_exercise_path(@exercise)
    assert_redirected_to new_user_session_path
    
    post exercises_path, params: { exercise: @exercise_params }
    assert_redirected_to new_user_session_path
    
    patch exercise_path(@exercise), params: { exercise: { description: "Updated description" } }
    assert_redirected_to new_user_session_path
    
    delete exercise_path(@exercise)
    assert_redirected_to new_user_session_path
  end
  
  # Basic CRUD tests for authenticated users
  test "should get index when authenticated" do
    sign_in_user
    get exercises_path
    assert_response :success
    assert_select "h1", "Exercises"
  end
  
  test "should show exercise when authenticated" do
    sign_in_user
    get exercise_path(@exercise)
    assert_response :success
    assert_select "h1", @exercise.name
  end
  
  test "should get new exercise form when authenticated" do
    sign_in_user
    get new_exercise_path
    assert_response :success
    assert_select "h1", "New Exercise"
  end
  
  test "should create exercise when authenticated" do
    sign_in_user
    assert_difference("Exercise.count") do
      post exercises_path, params: { exercise: @exercise_params }
    end
    
    new_exercise = Exercise.last
    assert_redirected_to exercise_path(new_exercise)
    assert_equal "Exercise was successfully created.", flash[:notice]
    
    # Verify titleize callback worked
    assert_equal "Bench Press", new_exercise.name
  end
  
  test "should get edit form when authenticated" do
    sign_in_user
    get edit_exercise_path(@exercise)
    assert_response :success
    assert_select "h1", "Edit Exercise"
  end
  
  test "should update exercise when authenticated" do
    sign_in_user
    patch exercise_path(@exercise), params: { 
      exercise: { description: "Updated description" } 
    }
    
    assert_redirected_to exercise_path(@exercise)
    assert_equal "Exercise was successfully updated.", flash[:notice]
    @exercise.reload
    assert_equal "Updated description", @exercise.description
  end
  
  test "should destroy exercise when authenticated" do
    sign_in_user
    assert_difference("Exercise.count", -1) do
      delete exercise_path(@exercise)
    end
    
    assert_redirected_to exercises_path
    assert_equal "Exercise was successfully destroyed.", flash[:notice]
  end
  
  # Validation tests
  test "should not create exercise with invalid data" do
    sign_in_user
    assert_no_difference("Exercise.count") do
      post exercises_path, params: { 
        exercise: { name: "", category: "Invalid" } 
      }
    end
    
    assert_response :unprocessable_entity
    assert_select ".text-red-700" # name error 
    assert_select ".text-red-700" # category error
  end
  
  test "should not update exercise with invalid data" do
    sign_in_user
    patch exercise_path(@exercise), params: { 
      exercise: { name: "" } 
    }
    
    assert_response :unprocessable_entity
    assert_select ".text-red-700" # name error
  end
  
  test "should enforce uniqueness of exercise name" do
    sign_in_user
    existing_name = @exercise.name.downcase # Test case-insensitive uniqueness
    
    assert_no_difference("Exercise.count") do
      post exercises_path, params: { 
        exercise: { 
          name: existing_name, 
          category: "Arms", 
          description: "Duplicate name test"
        } 
      }
    end
    
    assert_response :unprocessable_entity
    assert_select ".text-red-700" # duplicate name error
  end
end
