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