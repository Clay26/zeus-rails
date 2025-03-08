require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    user = User.new(name: "Test User", password: "password123")
    assert_not user.save, "Saved the user without an email"
  end

  test "should not save user without name" do
    user = User.new(email: "test@example.com", password: "password123")
    assert_not user.save, "Saved the user without a name"
  end

  test "should not save user with invalid email format" do
    user = User.new(name: "Test User", email: "invalid-email", password: "password123")
    assert_not user.save, "Saved the user with an invalid email format"
  end

  test "should not save user with too short password" do
    user = User.new(name: "Test User", email: "test@example.com", password: "short")
    assert_not user.save, "Saved the user with a too short password"
  end

  test "should save valid user" do
    user = User.new(name: "Test User", email: "valid@example.com", password: "password123")
    assert user.save, "Could not save a valid user"
  end

  test "should have many workouts" do
    assert_respond_to User.new, :workouts
  end
end
