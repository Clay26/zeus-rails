ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end

  # Devise integration
  class ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
    
    def sign_in_user(user = nil)
      user ||= users(:regular_user) # Default to a regular user fixture
      sign_in user
      user
    end
  end
end
