# RepOsitory

A personal workout and physical therapy tracker: log every set, track how PT sessions affect pain, follow planned programs, and see progress over time. The name is a pun: a repository of reps.

## Status

Requirements and data design phase. No application code yet.

## Planned for v1

- **Two users** (me and my partner), chosen from a simple list. No login yet; the app stays private to our own devices.
- **Workout programs:** plan a program ahead of time as days (optionally grouped by week), each with planned exercises and target sets. Programs can mix PT and regular exercises.
- **Logging:** record workout sessions, the exercises in each, and every set individually (reps, weight, RPE, rest, notes), either from a program day or as a one-off
- **Planned vs. actual:** a session started from a program copies in the targets, so each set records both what was planned and what was performed
- **PT tracking:** mark an exercise as PT within a session, and optionally rate pain (0-10) at the start and end of a session to see whether PT is reducing pain
- **Body weight over time**, with a goal weight
- View past sessions exactly as logged

## Planned for v2

- **Login** (top priority), so the app can safely be reachable from anywhere

## Later ideas

- Sharing programs by copying them, so the original stays untouched and can be rerun
- Tracking percent of one-rep max (1RM)
- More body measurements, such as body fat percentage
- Exercise videos
- A muscle map showing which muscles each exercise works

## Data model highlights

Full details, rules, and the reasoning behind each decision are in [schema.md](schema.md).

- **Plan and log are separate.** Programs hold targets; sessions hold what actually happened. That keeps a program reusable and shareable.
- **One row per set**, so every set keeps its own reps, weight, RPE, and rest.
- **History over overwrites.** Body weight is logged as dated entries, so progress is kept rather than replaced.
- **Exercises map to muscles with a role** (primary or stabilizer), which will power the muscle map later.

## How work is tracked

- Requirements are written as user stories in Jira under the project key **REP**.
- Jira and GitHub are connected: any commit, branch, or pull request that includes an issue key (for example, `REP-2: add sets table`) shows up on that issue in Jira.
