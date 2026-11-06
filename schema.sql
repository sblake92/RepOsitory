CREATE TABLE users(id TEXT PRIMARY KEY NOT NULL, 
name TEXT NOT NULL, 
username TEXT UNIQUE COLLATE NOCASE NOT NULL,
password_hash TEXT NULL, 
height REAL, height_unit TEXT,
goal_weight REAL, 
goal_weight_unit TEXT);

CREATE TABLE body_metrics(id TEXT PRIMARY KEY NOT NULL,
user_id TEXT NOT NULL,
date TEXT NOT NULL, weight REAL NOT NULL, 
weight_unit TEXT NOT NULL,
notes TEXT,
FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE program(id TEXT PRIMARY KEY NOT NULL,
user_id TEXT NOT NULL,
name TEXT  NOT NULL,
focus TEXT NOT NULL,
notes TEXT,
FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE program_day(id TEXT PRIMARY KEY NOT NULL,
program_id TEXT NOT NULL, 
day_number INTEGER NOT NULL,
week_number INTEGER NOT NULL,
notes TEXT,
FOREIGN KEY (program_id) REFERENCES program(id)
);

CREATE TABLE program_day_exercise(id TEXT PRIMARY KEY NOT NULL,
program_day_id TEXT NOT NULL,
exercise_id TEXT NOT NULL,
position INTEGER NOT NULL,
is_pt INTEGER,
notes TEXT,
FOREIGN KEY(program_day_id) REFERENCES program_day(id),
FOREIGN KEY(exercise_id) REFERENCES exercises(id)
);

CREATE TABLE planned_set(id TEXT PRIMARY KEY NOT NULL,
program_day_exercise_id TEXT NOT NULL,
set_number INTEGER NOT NULL,
target_reps INTEGER NOT NULL,
target_weight REAL,
weight_unit TEXT,
target_rest INTEGER,
FOREIGN KEY(program_day_exercise_id) REFERENCES program_day_exercise(id)
);

CREATE TABLE session(id TEXT PRIMARY KEY NOT NULL,
user_id TEXT NOT NULL,
program_day_id TEXT,
date_time TEXT NOT NULL,
pain_before INTEGER,
pain_after INTEGER,
notes TEXT,
FOREIGN KEY(user_id) REFERENCES users(id),
FOREIGN KEY(program_day_id) REFERENCES program_day(id)
);

CREATE TABLE session_to_exercise(id TEXT PRIMARY KEY NOT NULL,
session_id TEXT NOT NULL,
exercise_id TEXT NOT NULL,
position INTEGER NOT NULL,
is_pt INTEGER NOT NULL DEFAULT 0,
notes TEXT,
FOREIGN KEY(session_id) REFERENCES session(id),
FOREIGN KEY(exercise_id) REFERENCES exercises(id)
);

CREATE TABLE sets(id TEXT PRIMARY KEY NOT NULL,
session_to_exercise_id TEXT NOT NULL,
set_number INTEGER NOT NULL,
target_reps INTEGER,
target_weight REAL,
performed_reps INTEGER,
performed_weight REAL,
weight_unit TEXT,
rpe REAL,
target_rest INTEGER,
rest INTEGER,
notes TEXT,
FOREIGN KEY(session_to_exercise_id) REFERENCES session_to_exercise(id)
);

CREATE TABLE exercises(id TEXT PRIMARY KEY NOT NULL,
name TEXT NOT NULL,
region TEXT
);

CREATE TABLE muscles(id TEXT PRIMARY KEY NOT NULL,
name TEXT NOT NULL,
region TEXT
);

CREATE TABLE exercise_to_muscle(exercise_id TEXT NOT NULL,
muscle_id TEXT NOT NULL,
role TEXT,
PRIMARY KEY(exercise_id, muscle_id),
FOREIGN KEY(exercise_id) REFERENCES exercises(id),
FOREIGN KEY(muscle_id) REFERENCES muscles(id)
);