CREATE TABLE USERS (id UUID NOT NULL PRIMARY KEY, 
name VARCHAR(50) NOT NULL, username VARCHAR(50) NOT NULL,
height DECIMAL(5, 2), height_unit VARCHAR(2),
goal_weight DECIMAL(6, 2), 
goal_weight_unit VARCHAR(2));