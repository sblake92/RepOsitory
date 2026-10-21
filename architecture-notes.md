# RepOsitory: Architecture Notes (offline and sync)

Working notes from architecture practice sessions. Worked out from requirements first, before drawing boxes. In progress; more to come.

## Requirement driving this

Gym signal is unreliable. With no signal, v1 must still let a user log a workout: start a session (from a program day or one-off), add exercises, and log sets.

## What the phone needs offline

**Created on the phone (writes):**
- session
- session_to_exercise
- sets

**Created elsewhere, read on the phone (must already be stored locally before signal is lost):**
- user (who is logging)
- program (to pick the program)
- program_day
- program_day_exercise (the link between a day and its planned sets)
- planned_set (targets copied into the log when a session starts)
- exercises (the list to pick from when adding an exercise mid-session)

So the same data lives in two places: the phone's local storage and the server database.

## Two sync directions

- **Push (phone → server):** sessions, their exercises, and sets. The phone reads its local storage, sends the rows to the FastAPI backend, and the backend writes them to the database.
- **Pull (server → phone):** programs, days, planned exercises, planned sets, exercises. Needed because programs are built on the computer and used on the phone.
- The **client always initiates**. In a client-server setup the server can't reliably reach a phone (offline, changing networks, asleep).
- Parked edge case: editing a past session from the computer would also need to come down to the phone.

## Pull triggers

- When the app is opened, while it has signal
- On a timer, but only while the app is open. iOS heavily limits background work, so a timer while the app is closed can't be relied on.
- More triggers still to explore.

**Known gap:** Sunday night, edit Day 3 on the laptop. Monday, first open the app at the gym with no signal. Every trigger above misses it, and the phone runs last week's targets. On a phone, this gap can be shrunk but never fully closed.

## Decision: availability over consistency

When the phone may be working from an out-of-date copy, it **still lets the user start the session** with the last data it has. Having old targets is a bummer; not being able to work out at all is worse. This is the availability-over-consistency tradeoff (CAP, eventual consistency) applied to the app.

## Making staleness visible

- Show a **"last synced" timestamp based on when the phone last successfully pulled**, not when the program was last edited. The phone can only know about edits it has received, so an "edited" time would look current even when it isn't. "Last pulled" draws an honest boundary: everything up to that moment is reflected; anything after, the phone can't know.
- A sync indicator is only fully honest on the **push** side: the phone knows exactly what hasn't been uploaded yet (e.g. "3 sessions waiting to sync"). On the **pull** side, offline, it can only say when it last checked, never whether it's up to date.

## Still to cover

- Remaining pull triggers
- What happens if a push fails partway or is retried (duplicates)
- Conflicts, if the same data is changed in two places
- How hosting (REP-17) fits into the picture
