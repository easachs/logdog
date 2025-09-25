puts "🌱 Starting database seeding..."

# Clear existing data to prevent duplicates
puts "🧹 Clearing existing data..."
# Clear in order to respect foreign key constraints
WorkoutSet.delete_all
WorkoutExercise.delete_all
WorkoutTemplateExercise.delete_all
WorkoutTemplate.delete_all
Exercise.delete_all
puts "✅ Cleared existing data"

puts "📝 Creating exercises..."
exercises = [
  # === PUSH ===
  {
    name: "Flat Barbell Bench Press",
    category: "Push",
    equipment: "Barbell",
    description: "Compound pressing movement targeting the chest, shoulders, and triceps using a flat bench and barbell."
  },
  {
    name: "Incline Barbell Bench Press",
    category: "Push",
    equipment: "Barbell",
    description: "Incline variation emphasizing the upper chest and shoulders using a barbell."
  },
  {
    name: "Incline Dumbbell Press",
    category: "Push",
    equipment: "Dumbbell",
    description: "Upper chest-focused press using dumbbells on an incline bench."
  },
  {
    name: "Overhead Press",
    category: "Push",
    equipment: "Barbell",
    description: "Standing or seated vertical press targeting the shoulders and triceps using a barbell."
  },
  {
    name: "Overhead Dumbbell Press",
    category: "Push",
    equipment: "Dumbbell",
    description: "Vertical shoulder press using dumbbells, working the deltoids and triceps."
  },
  {
    name: "Military Press",
    category: "Push",
    equipment: "Barbell",
    description: "Strict standing overhead press emphasizing the front delts and core stability."
  },
  {
    name: "Dips",
    category: "Push",
    equipment: "Bodyweight",
    description: "Bodyweight pushing movement emphasizing the lower chest and triceps."
  },
  {
    name: "Dumbbell Flys",
    category: "Push",
    equipment: "Dumbbell",
    description: "Chest isolation movement with a wide arc, focusing on pec stretch and contraction."
  },
  {
    name: "Machine Flys",
    category: "Push",
    equipment: "Machine",
    description: "Chest isolation movement using a pec deck or cable machine for controlled motion."
  },
  {
    name: "Skull Crushers",
    category: "Push",
    equipment: "EZ Bar",
    description: "Triceps isolation exercise performed lying down with controlled elbow extension."
  },
  {
    name: "Lateral Raises",
    category: "Push",
    equipment: "Dumbbell",
    description: "Shoulder isolation movement targeting the lateral deltoids."
  },
  {
    name: "Thrusters",
    category: "Push",
    equipment: "Dumbbell",
    description: "Compound full-body movement combining a squat and overhead press."
  },

  # === PULL ===
  {
    name: "Pull-Ups",
    category: "Pull",
    equipment: "Bodyweight",
    description: "Vertical pulling movement targeting the lats, biceps, and upper back."
  },
  {
    name: "Barbell Row",
    category: "Pull",
    equipment: "Barbell",
    description: "Horizontal pulling exercise focusing on mid-back, lats, and rear delts."
  },
  {
    name: "Dumbbell Row",
    category: "Pull",
    equipment: "Dumbbell",
    description: "Unilateral pulling exercise targeting the lats and rhomboids."
  },
  {
    name: "Cable Row",
    category: "Pull",
    equipment: "Cable",
    description: "Horizontal back row using cables to isolate mid-back and lats."
  },
  {
    name: "Seated Row (Machine)",
    category: "Pull",
    equipment: "Machine",
    description: "Controlled back row targeting the rhomboids and mid traps."
  },
  {
    name: "High Row (Machine)",
    category: "Pull",
    equipment: "Machine",
    description: "Machine row at a high angle, emphasizing upper back and rear delts."
  },
  {
    name: "Face Pulls",
    category: "Pull",
    equipment: "Cable",
    description: "Rear delt and upper trap exercise using a rope and cable machine."
  },
  {
    name: "Hammer Curls",
    category: "Pull",
    equipment: "Dumbbell",
    description: "Biceps and brachialis curl using a neutral grip for forearm emphasis."
  },
  {
    name: "Bicep Curls",
    category: "Pull",
    equipment: "Dumbbell",
    description: "Classic biceps isolation exercise using dumbbells with a supinated grip."
  },
  {
    name: "EZ Bar Curls",
    category: "Pull",
    equipment: "EZ Bar",
    description: "Arm exercise targeting the biceps with reduced wrist strain."
  },
  {
    name: "Romanian Deadlift",
    category: "Pull",
    equipment: "Barbell",
    description: "Hip hinge targeting the hamstrings and glutes with a barbell."
  },
  {
    name: "Romanian Deadlift (Dumbbell)",
    category: "Pull",
    equipment: "Dumbbell",
    description: "Dumbbell variation of the RDL for posterior chain work."
  },

  # === CORE ===
  {
    name: "Sit-Ups",
    category: "Core",
    equipment: "Bodyweight",
    description: "Abdominal flexion movement targeting the rectus abdominis."
  },
  {
    name: "Planks",
    category: "Core",
    equipment: "Bodyweight",
    description: "Isometric core hold engaging the entire trunk."
  },
  {
    name: "Side Planks",
    category: "Core",
    equipment: "Bodyweight",
    description: "Isometric oblique hold targeting the lateral core."
  },
  {
    name: "Hanging Leg Raises",
    category: "Core",
    equipment: "Bodyweight",
    description: "Advanced core movement emphasizing the lower abs while hanging."
  },
  {
    name: "Trunk Rotation (Machine)",
    category: "Core",
    equipment: "Machine",
    description: "Rotational abdominal movement targeting the obliques."
  },

  # === LEGS ===
  {
    name: "Squats",
    category: "Legs",
    equipment: "Barbell",
    description: "Full-body compound lift primarily targeting quads, glutes, and hamstrings."
  },
  {
    name: "Split Squats",
    category: "Legs",
    equipment: "Dumbbell",
    description: "Unilateral squat variation targeting quads, glutes, and balance."
  },
  {
    name: "Leg Press",
    category: "Legs",
    equipment: "Machine",
    description: "Machine-based compound leg movement emphasizing quads and glutes."
  }
]

exercises.each do |attrs|
  Exercise.create!(attrs)
end
puts "✅ Created #{Exercise.count} exercises"

# Create workout templates
puts "🏋️ Creating workout templates..."

# Push Day Template
puts "  📝 Creating Push Day template..."
push_template = WorkoutTemplate.create!(
  name: "Push Day",
  description: "Upper body pushing movements focusing on chest, shoulders, and triceps"
)

# Add exercises to push template
push_exercises = [
  { name: "Flat Barbell Bench Press", order: 1, notes: "3-4 sets, 6-8 reps" },
  { name: "Overhead Press", order: 2, notes: "3-4 sets, 6-8 reps" },
  { name: "Incline Dumbbell Press", order: 3, notes: "3 sets, 8-10 reps" },
  { name: "Dips", order: 4, notes: "3 sets, 8-12 reps" },
  { name: "Lateral Raises", order: 5, notes: "3 sets, 10-15 reps" },
  { name: "Skull Crushers", order: 6, notes: "3 sets, 8-12 reps" }
]

push_exercises.each do |exercise_data|
  exercise = Exercise.find_by(name: exercise_data[:name])
  if exercise
    push_template.workout_template_exercises.create!(
      exercise: exercise,
      order: exercise_data[:order],
      notes: exercise_data[:notes]
    )
  end
end

# Pull Day Template
puts "  📝 Creating Pull Day template..."
pull_template = WorkoutTemplate.create!(
  name: "Pull Day",
  description: "Upper body pulling movements focusing on back, biceps, and rear delts"
)

# Add exercises to pull template
pull_exercises = [
  { name: "Pull-Ups", order: 1, notes: "3-4 sets, 6-10 reps" },
  { name: "Barbell Row", order: 2, notes: "3-4 sets, 6-8 reps" },
  { name: "Dumbbell Row", order: 3, notes: "3 sets, 8-10 reps" },
  { name: "Face Pulls", order: 4, notes: "3 sets, 12-15 reps" },
  { name: "Bicep Curls", order: 5, notes: "3 sets, 8-12 reps" },
  { name: "Hammer Curls", order: 6, notes: "3 sets, 8-12 reps" }
]

pull_exercises.each do |exercise_data|
  exercise = Exercise.find_by(name: exercise_data[:name])
  if exercise
    pull_template.workout_template_exercises.create!(
      exercise: exercise,
      order: exercise_data[:order],
      notes: exercise_data[:notes]
    )
  end
end

# Leg Day Template
puts "  📝 Creating Leg Day template..."
leg_template = WorkoutTemplate.create!(
  name: "Leg Day",
  description: "Lower body compound movements for strength and muscle development"
)

# Add exercises to leg template
leg_exercises = [
  { name: "Squats", order: 1, notes: "4-5 sets, 5-8 reps" },
  { name: "Romanian Deadlift", order: 2, notes: "3-4 sets, 6-8 reps" },
  { name: "Split Squats", order: 3, notes: "3 sets, 8-10 reps each leg" },
  { name: "Leg Press", order: 4, notes: "3 sets, 10-15 reps" },
  { name: "Planks", order: 5, notes: "3 sets, 30-60 seconds" }
]

leg_exercises.each do |exercise_data|
  exercise = Exercise.find_by(name: exercise_data[:name])
  if exercise
    leg_template.workout_template_exercises.create!(
      exercise: exercise,
      order: exercise_data[:order],
      notes: exercise_data[:notes]
    )
  end
end

# Full Body Template
puts "  📝 Creating Full Body template..."
full_body_template = WorkoutTemplate.create!(
  name: "Full Body",
  description: "Complete workout hitting all major muscle groups"
)

# Add exercises to full body template
full_body_exercises = [
  { name: "Squats", order: 1, notes: "3 sets, 8-10 reps" },
  { name: "Flat Barbell Bench Press", order: 2, notes: "3 sets, 8-10 reps" },
  { name: "Barbell Row", order: 3, notes: "3 sets, 8-10 reps" },
  { name: "Overhead Press", order: 4, notes: "3 sets, 8-10 reps" },
  { name: "Pull-Ups", order: 5, notes: "3 sets, 6-10 reps" },
  { name: "Planks", order: 6, notes: "3 sets, 30-60 seconds" }
]

full_body_exercises.each do |exercise_data|
  exercise = Exercise.find_by(name: exercise_data[:name])
  if exercise
    full_body_template.workout_template_exercises.create!(
      exercise: exercise,
      order: exercise_data[:order],
      notes: exercise_data[:notes]
    )
  end
end

puts "✅ Created #{WorkoutTemplate.count} workout templates!"
puts "🎉 Database seeding completed successfully!"
puts "📊 Summary:"
puts "   • #{Exercise.count} exercises"
puts "   • #{WorkoutTemplate.count} workout templates"
puts "   • #{WorkoutTemplateExercise.count} template exercises"
