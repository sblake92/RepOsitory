# Data Model

Draft schema for v1. Column types are placeholders until the database is chosen.

## Overview

There are two sides to the data:

- **Reference data:** facts that are true about exercises no matter who does them or when (`muscles`, `exercises`, `exercise_to_muscle`).
- **Tracking data:** what actually happened in a workout (`sessions`, `session_to_exercise`, `sets`).

```
muscles ──< exercise_to_muscle >── exercises
                                       │
sessions ──< session_to_exercise >─────┘
                    │
                    └──< sets
```

## Tables

### muscles

| Column | Notes |
|---|---|
| id | Primary key |
| name | e.g. quads, glutes |
| region | e.g. lower body |

### exercises

| Column | Notes |
|---|---|
| id | Primary key |
| name | e.g. squat |
| region | e.g. lower body |

### exercise_to_muscle

Junction table: one exercise works many muscles, and one muscle is worked by many exercises.

| Column | Notes |
|---|---|
| exercise_id | Foreign key → exercises |
| muscle_id | Foreign key → muscles |
| role | primary or secondary/stabilizer |

### sessions

One instance of working out, such as Tuesday morning PT.

| Column | Notes |
|---|---|
| id | Primary key |
| date_time | When the session happened |
| pain_before | Optional, 0-10 |
| pain_after | Optional, 0-10 |
| notes | Notes about the whole session |

### session_to_exercise

One exercise as performed within one session.

| Column | Notes |
|---|---|
| id | Primary key |
| session_id | Foreign key → sessions |
| exercise_id | Foreign key → exercises |
| order | Position of this exercise in the session |
| is_pt | Whether this exercise was done as PT in this session |
| notes | Notes about this exercise in this session |

### sets

| Column | Notes |
|---|---|
| id | Primary key |
| session_to_exercise_id | Foreign key → session_to_exercise |
| set_number | 1, 2, 3, ... |
| reps | |
| weight | |
| rpe | Rate of perceived exertion |
| rest | Rest after this set |
| notes | Notes about this set |

## Rules

- **The same exercise can appear more than once in a session** (for example, PT squats at the start and regular squats at the end). Do not make `session_id` + `exercise_id` unique in `session_to_exercise`.
- **Pain ratings are optional.** Non-PT sessions can be saved without them.
- **Each fact is stored once.** A set points only to its `session_to_exercise` row, which already knows the session and the exercise.

## Design decisions

- **Exercise-to-muscle role lives on the junction table**, because the same muscle can be primary in one exercise and a stabilizer in another.
- **One row per set**, so each set's reps, weight, RPE, and rest are kept. The number of sets comes from counting rows.
- **`is_pt` lives on `session_to_exercise`, not `exercises`**, because the same exercise can be PT in one context and regular in another.
- **Pain is rated per session, not per exercise** (REP-3), to keep logging quick. Per-exercise pain can go in exercise notes; revisit if a pattern shows up.
