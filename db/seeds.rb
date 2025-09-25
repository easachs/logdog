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
