# RepOsitory

A personal workout and physical therapy tracker: log every set, track how PT sessions affect pain, follow planned programs, and see progress over time. The name is a pun: a repository of reps.

## Status

Requirements and data design phase. No application code yet.

## Planned for v1

- Log workout sessions, the exercises in each, and every set individually (reps, weight, RPE, rest, notes)
- Mark an exercise as PT within a session, so the same exercise can be PT one day and regular the next
- Optionally rate pain (0-10) at the start and end of a session, to see whether PT is reducing pain
- View past sessions exactly as logged

## Designed, scope to be decided

The data model already supports these; whether they ship in v1 is still open.

- **Users:** each user owns their sessions and programs
- **Workout programs:** plan a program ahead of time as days (optionally grouped by week), each with planned exercises and target sets. Programs can mix PT and regular exercises.
- **Planned vs. actual:** a session started from a program copies in the targets, so each set records both what was planned and what was performed
- **Sharing:** a program is shared by copying it, so the original stays untouched and can be rerun

## Later ideas

- Tracking percent of one-rep max (1RM)
- Exercise videos
- A muscle map showing which muscles each exercise works
- Login ability top priority for V2

## Data model highlights

Full details, rules, and the reasoning behind each decision are in [schema.md](schema.md).

- **Plan and log are separate.** Programs hold targets; sessions hold what actually happened. That keeps a program reusable and shareable.
- **One row per set**, so every set keeps its own reps, weight, RPE, and rest.
- **Exercises map to muscles with a role** (primary or stabilizer), which will power the muscle map later.

## How work is tracked

- Requirements are written as user stories in Jira under the project key **REP**.
- Jira and GitHub are connected: any commit, branch, or pull request that includes an issue key (for example, `REP-2: add sets table`) shows up on that issue in Jira.
