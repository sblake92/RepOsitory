# Data Model

Draft schema for v1 RepOsitory. Column types are placeholders until database is chosen

## Overview

This database is designed to store exercises and exercise data that will enable users to track their progress
The data is broken into four categories:
- **User Data** who is using the app and their body metrics over time ('user', 'body_metrics').
- **Reference Data** facts that are always true ('muscles', 'exercises', 'exercise_to_muscle').
- **Plan Data** workouts designed before they are performed ('program', 'program_day', 'program_day_exercise', 'planned_set').
- **Tracking Data** what actually happened in a workout ('session', 'session_to_exercise', 'sets').

Plan data and tracking data have nearly the same shape, but they are kept separate: a plan holds targets, a log holds what was performed.

More data categories may present themselves as being necessary in future versions

## Structural Concept

```
body_metrics >--+
                |
user --< program --< program_day --< program_day_exercise --< planned_set
  |                       :
  |                       : (optional link back to the planned day)
  |                       :
  +---< session ..........+
          |
          +--< session_to_exercise --< sets
                      |
exercises -----------+  (also referenced by program_day_exercise)
    |
    +--< exercise_to_muscle >-- muscles
```

`--<` means one-to-many: the left side has many of the right side.

## Tables

### user
--| Individual using the app/tracking progress

--| Each row will contain a unique user id and name, username, and a password hash for secure login
--| **NOTE** v1 has no login: users pick who they are from a list, and the app is kept private to our own devices.
--| Login is the top priority for v2; password_hash is unused until then.

| Column | Type | Notes |
|---|---|---|
| id | int |Primary key |
| name | VARCHAR(50) |e.g Blake |
| username | VARCHAR(50) |e.g. BlakeyBoy | 
| password_hash | VARCHAR(255) | v2. Hashed password only; the plain password is never stored |
| height | DECIMAL(5,2) | Optional |
| height_unit | VARCHAR(2) | in or cm |
| goal_weight | DECIMAL(6,2) | Optional |
| goal_weight_unit | VARCHAR(2) | lb or kg |

### body_metrics
--| One body measurement entry, e.g. a weigh-in

--| Each row records a user's measurements on a given date, so progress over time is kept
--| rather than overwritten. Named broadly so other measurements (body fat %, waist)
--| can be added later as optional columns.

| Column | Type | Notes |
|---|---|---|
| id | int | Primary key |
| user_id | int | Foreign key -> user |
| date | Date | When the measurement was taken |
| weight | DECIMAL(6,2) | |
| weight_unit | VARCHAR(2) | lb or kg |
| notes | TEXT | Optional context, e.g. "after vacation" |

### program
--| A planned workout program, e.g. a purchased or downloaded program, or one the user builds

--| Each row is one program owned by one user, i.e. Program 123: Kettlebell. A program is the
--| top of the plan: its days, exercises, and target sets live in the plan tables below it.

--| **NOTE** programs will likely be able to be shared. A shared program is copied: the copy is a new
--| row with its own unique id and the new owner's user_id. A user can have any number of programs,
--| including several with the same name.

| Column | Type | Notes |
|---|---|---|
| id | int |Primary key |
| user_id | int | Foreign key -> user (owner) |
| name | VARCHAR(255) | e.g. KettleBell
| focus | VARCHAR(255) | e.g. build muscle, lose weight, gain strength etc |
| notes | TEXT | Notes about the program |


### program_day
--| One planned day in a program, e.g. Day 1 or Week 3, Day 2

--| Programs come in two forms: a plain sequence of days, or weeks and days.
--| day_number orders the days in the program; week_number is filled in only for week-based programs.

| Column | Type | Notes |
|---|---|---|
| id | int | Primary key |
| program_id | int | Foreign key -> program |
| day_number | smallint | Order of this day in the program (1, 2, 3, ...) |
| week_number | smallint | Optional; only for week-based programs |
| notes | TEXT | Notes about this day |

### program_day_exercise
--| One planned exercise within a planned day

--| Mirrors session_to_exercise on the plan side.

| Column | Type | Notes |
|---|---|---|
| id | int | Primary key |
| program_day_id | int | Foreign key -> program_day |
| exercise_id | int | Foreign key -> exercises |
| position | smallint | Position of this exercise in the day |
| is_pt | boolean | Whether this exercise is planned as PT |
| notes | TEXT | Notes about this exercise in this day |

### planned_set
--| One target set for a planned exercise, e.g. 8 reps at 135 lb

--| Mirrors sets on the plan side. Holds targets only; nothing performed is ever written here.

| Column | Type | Notes |
|---|---|---|
| id | int | Primary key |
| program_day_exercise_id | int | Foreign key -> program_day_exercise |
| set_number | smallint | 1, 2, 3, ... |
| target_reps | smallint | |
| target_weight | DECIMAL(6,2) | Optional |
| weight_unit | VARCHAR(2) | lb or kg |
| target_rest | time | Optional; planned rest after this set |

### session
--| One instance of working out, i.e. Monday Lift

--| each row contains a unique id, the date the session occurred, optional before/after
--| pain assessment and any notes the user has about the session. 

| Column | Type | Notes |
|---|---|---|
| id | int | Primary key |
| user_id | int | Foreign key -> user (required; every session has an owner) |
| program_day_id | int | Optional foreign key -> program_day; empty for one-off sessions |
| date_time | DateTime |When the session happened |
| pain_before | smallint |Optional, 0-10 |
| pain_after | smallint |Optional, 0-10 |
| notes | TEXT | Notes about the whole session |

### session_to_exercise
--| One exercise as performed within one session.

--| This table holds exercises that exist within a session. For example, Squats can exist in different sessions
--| and each session might have more than one instance of squats, but the specific instance is tracked
--| in this table. Additionally, the ability to differentiate between physical therapy versions of 
--| exercises and non-pt variations. Users can also leave any notes of the session they have. 

| Column | Type | Notes |
|---|---|---|
| id | int | Primary key |
| session_id | int |Foreign key -> sessions |
| exercise_id | int | Foreign key -> exercises |
| position | smallint | Position of this exercise in the session |
| is_pt | boolean | Whether this exercise was done as PT in this session |
| notes | TEXT | Notes about this exercise in this session |

### sets
--| A specific set within a session

--| A set is exercise data for an instance of an exercise. For example the exercise might be bench
--| each row is one set, containing its reps, weight, rate of perceived exertion (RPE)
--| and rest period. I.e. Set of Bench is made up of 12 reps at 225 lbs with a 45 sec rest. 
--| the user will indicate their RPE after performing the set and can add any notes they wish

| Column | Type | Notes |
|---|---|---|
| id | int | Primary key |
| session_to_exercise_id | int |Foreign key → session_to_exercise |
| set_number | smallint | 1, 2, 3, ... |
| target_reps | smallint | Optional; copied from planned_set when the session comes from a program |
| target_weight | DECIMAL(6,2) | Optional; copied from planned_set when the session comes from a program |
| performed_reps | smallint | What was actually done |
| performed_weight | DECIMAL(6,2) | What was actually lifted; allows fractional weights, e.g. 22.5 |
| weight_unit | VARCHAR(2) | lb or kg |
| rpe | DECIMAL(3,1) | Rate of perceived exertion, 1-10 scale (half steps allowed, e.g. 8.5) |
| target_rest | time | Optional; copied from planned_set when the session comes from a program |
| rest | time | Rest actually taken after this set |
| notes | TEXT | Notes about this set |

### exercises
--| A single exercise

--| This table holds unique exercises and the region of body they affect
--| For example: Exercise - Bench Press ; Region - Chest 

| Column | Type | Notes |
|---|---|---|
| id | int | Primary key |
| name | VARCHAR(255) | e.g. squat |
| region | VARCHAR(255) | e.g. lower body |


### exercise_to_muscle
--| Junction table: one exercise works many muscles, and one muscle is worked by many exercises.

| Column | Type | Notes |
|---|---|---|
| exercise_id | int | Foreign key → exercises |
| muscle_id | int | Foreign key → muscles |
| role | undecided | primary or secondary/stabilizer |

### muscles
--| Represents individual muscle in body

--| Each row will contain a primary unique id per muscle. I.e glute - 123
--| muscles are grouped regionally to enable users to more conveniently build workout programs
--| and select exercises that target those muscles within a region. 

| Column | Type | Notes |
|---|---|---|
| id | int |Primary key |
| name | VARCHAR(50) |e.g. quads, glutes |
| region | VARCHAR(50) | e.g. lower body |

## Rules

- **The same exercise can appear more than once in a session** (for example, PT squats at the start and regular squats at the end). Do not make `session_id` + `exercise_id` unique in `session_to_exercise`.
- **Pain ratings are optional.** Non-PT sessions can be saved without them.
- **Every session has an owner.** `session.user_id` is required, whether or not the session came from a program.
- **Plan tables only hold targets.** Performed values are only ever written to the log (`sets`).
- **Each fact is stored once.** A set points only to its `session_to_exercise` row, which already knows the session and the exercise.

## Design decisions

- **Exercise-to-muscle role lives on the junction table**, because the same muscle can be primary in one exercise and a stabilizer in another.
- **One row per set**, so each set's reps, weight, RPE, and rest are kept. The number of sets comes from counting rows.
- **`is_pt` lives on `session_to_exercise`, not `exercises`**, because the same exercise can be PT in one context and regular in another.
- **Pain is rated per session, not per exercise** (REP-3), to keep logging quick. Per-exercise pain can go in exercise notes; revisit if a pattern shows up.
- **Plan and log live in separate tables.** If planned targets lived in logged rows, rerunning a program would mean copying from a previous run that already holds results, and sharing a program would mean sharing workout history. Keeping the plan separate makes it reusable and shareable.
- **Targets are copied into the log when a session starts.** Each logged set keeps both target and performed values, so planned versus actual can be compared set by set.
- **Programs are one-to-many with users, so `user_id` is a column on program, not a junction table.** Sharing copies a program rather than having many users follow the same row. If that ever changes, a junction table would be needed.
- **Weight is a history table, not a column on user.** A single current_weight column would be overwritten on every update, losing exactly the progress the app exists to show. Height and goal weight change rarely, so they stay on user.
- **BMI is not stored.** It is calculated entirely from height and weight, so storing it would duplicate data and could fall out of sync. It can be calculated for display if ever needed; better body composition measures can be added to body_metrics later.
- **Weeks are a column, not a table.** In real programs weeks are mostly labels; promote to a table if weeks ever need their own details.

## Open questions

- **Percent of one-rep max (1RM):** worth tracking, for example to plan sets at 70% of 1RM. Where it lives is undecided.
