# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing exercises to avoid duplicates
puts "Clearing existing exercises..."
Exercise.destroy_all

# Create array of exercise data with the correct categories
exercises = [
  # Chest exercises
  { name: "Bench Press", category: "Chest", description: "A compound chest exercise performed on a flat bench." },
  { name: "Incline Bench Press", category: "Chest", description: "A compound chest exercise that targets the upper chest." },
  { name: "Dumbbell Fly", category: "Chest", description: "An isolation chest exercise performed with dumbbells." },
  { name: "Push-up", category: "Chest", description: "A bodyweight exercise that targets the chest, shoulders, and triceps." },
  
  # Back exercises
  { name: "Pull-up", category: "Back", description: "A compound back exercise performed by pulling yourself up to a bar." },
  { name: "Barbell Row", category: "Back", description: "A compound back exercise that targets the middle back and lats." },
  { name: "Lat Pulldown", category: "Back", description: "A machine exercise that targets the latissimus dorsi muscles." },
  { name: "Deadlift", category: "Back", description: "A compound full body exercise that primarily targets the posterior chain." },
  
  # Legs exercises
  { name: "Squat", category: "Legs", description: "A compound lower body exercise that targets the quadriceps, hamstrings, and glutes." },
  { name: "Leg Press", category: "Legs", description: "A lower body exercise targeting the quadriceps, performed on a machine." },
  { name: "Romanian Deadlift", category: "Legs", description: "A hamstring-focused variation of the deadlift." },
  { name: "Calf Raise", category: "Legs", description: "An isolation exercise targeting the calves." },
  
  # Shoulders exercises
  { name: "Overhead Press", category: "Shoulders", description: "A compound shoulder exercise performed standing with a barbell." },
  { name: "Lateral Raise", category: "Shoulders", description: "An isolation shoulder exercise targeting the lateral deltoids." },
  { name: "Face Pull", category: "Shoulders", description: "A rear deltoid and upper back exercise performed with a cable machine." },
  
  # Arms exercises
  { name: "Bicep Curl", category: "Arms", description: "An isolation exercise targeting the biceps." },
  { name: "Tricep Extension", category: "Arms", description: "An isolation exercise targeting the triceps." },
  { name: "Hammer Curl", category: "Arms", description: "A bicep exercise that also targets the brachialis and forearms." },
  
  # Core exercises
  { name: "Plank", category: "Core", description: "An isometric core exercise that strengthens the abdominals and back." },
  { name: "Russian Twist", category: "Core", description: "A rotational exercise that targets the obliques." },
  { name: "Leg Raise", category: "Core", description: "A lower abdominal exercise performed by raising the legs while lying on the back." },
  
  # Cardio exercises
  { name: "Running", category: "Cardio", description: "A cardiovascular exercise performed at various intensities." },
  { name: "Cycling", category: "Cardio", description: "A low-impact cardiovascular exercise performed on a bicycle or stationary bike." },
  { name: "Rowing", category: "Cardio", description: "A full-body cardiovascular exercise performed on a rowing machine." }
]

# Create exercises
puts "Creating exercises..."
exercises.each do |exercise_data|
  exercise = Exercise.create!(exercise_data)
  puts "Created exercise: #{exercise.name} (#{exercise.category})"
end

puts "Created #{Exercise.count} exercises successfully!"
