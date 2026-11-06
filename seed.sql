INSERT INTO equipment(id, name)
VALUES
    ('ad39e5f3-3234-44cb-b641-41bfaa50c337', 'Barbell'),
    ('6e8b4fdd-92de-42ba-b373-87c40fa5414f', 'Dumbbell'),
    ('b7baeeca-2d40-49cf-8c84-65ab30986bf8', 'KettleBell'),
    ('cfcd4570-99fc-4c93-b0c0-c5cf0a371430', 'Bodyweight'),
    ('b61ea283-3da2-43ca-b88c-609f584fa2fc', 'Cable'),
    ('d01ad230-ef4b-4cb5-a280-8fe2abcbb658', 'Machine').
    ('1f61aaf4-8445-4aa7-b9bc-bbd60fd34bbf', 'Tire'),
    ('2f729af5-d52f-4aad-8a0d-d87616f54b3b', 'Sled'),
    ('2dcd4b84-70b9-4507-892d-86a2820be290', 'Band'),
    ('6a3981e0-30da-4c8c-9496-a549f0379efd', 'Treadmill'),
    ('cfab6e3c-c9bb-4b08-89e9-50c5f03251aa', 'Elliptical'),
    ('bd128b9c-60bd-4198-97a9-813781791144', 'Stair-Climber'),
    ('67249822-2bed-4f22-a88f-0011cf8e83e6', 'Row-Machine'),
    ('be547254-2d71-48a9-99fc-852058ac6cc1', 'TRX'),
    ('812e6dac-2a7b-4d9c-986f-d84aae45883d', 'Smith-Machine')
    ('9b34734f-864d-4c1a-a213-630366a1961d', 'Hex-Bar');
    ('10c1d20d-9e61-4e56-b2a0-207c9b5d38d6', 'Weighted-Belt');

INSERT INTO exercises (id, name, region, default_equipment_id)
VALUES
    ('e6ff43a7-253c-4fca-991e-f2e25d4164d4', 'Squat', 'Leg', (SELECT id from equipment WHERE name = 'Bodyweight')),
    ('fce7035e-d6cb-4809-b384-a0823e85bed8', 'Leg Curl', 'Leg',(SELECT id from equipment WHERE name = 'Machine')),
    ('f3d256e4-c82c-4262-8211-ca19d0bdc93b', 'Leg Extension', 'Leg', (SELECT id from equipment WHERE name = 'Machine')),
    ('1aada8af-113e-43af-8434-631ec6098335', 'Calf Raise', 'Leg',),
    ('446c24e8-8af8-4c11-87f0-bebba45ca11a', 'Deadlift', 'Leg'),
    ('3c529aba-a717-454c-a38d-1ecf6c5057b4', 'Romanian Deadlift', 'Leg'),
    ('9491b3ae-3215-4520-806e-c379dca6e4e5', 'Lunge', 'Leg'),
    ('f68db8f7-df64-4c62-a0cd-bb9f0e6df751', 'Bulgarian Split Squat', 'Leg'),
    ('c76ebaa0-0340-4837-935b-ea9fa576ac15', 'Leg Press', 'Leg', (SELECT id from equipment WHERE name = 'Machine')),
    ('ad2a705b-a6f8-4d87-acd9-2ee749d26392', 'Hip Thrust', 'Leg'),
    ('acb26dc5-d0a5-4cb1-a6bc-87e40545092a', 'Swing', 'Leg'),
    ('6b297a07-3f62-4037-900b-b3e464690387', 'Flat Press', 'Chest', (SELECT id from equipment WHERE name = 'Machine')),
    ('75b074c0-b645-417d-8153-96564cb345a6', 'Incline Press', 'Chest'),
    ('0f62daca-1a37-4cb1-bc50-4add2a24931f', 'Push-Up', 'Chest'),
    ('b367a912-0c88-4eb9-af26-e98645536af3', 'Chest Fly', 'Chest',(SELECT id from equipment WHERE name = 'Dumbbell')),
    ('d1cc045f-88d7-4889-bfae-2b69bbb00c71', 'Pull-Up', 'Back'),
    ('27bc6910-a800-4a5f-8b60-32d70d944a6a', 'Lat Pulldown', 'Back', (SELECT id from equipment WHERE name = 'Machine')),
    ('914defbe-d741-4acd-aa9c-c726328fffed', 'Row', 'Back'),
    ('e79313cb-e3f6-4260-ad69-0feea30b74c5', 'Seated Row', 'Back', (SELECT id from equipment WHERE name = 'Machine')),
    ('3a54380d-27f1-433c-b913-2e40776f1669', 'Single-Arm Row', 'Back',(SELECT id from equipment WHERE name = 'Dumbbell')),
    ('b8cba394-3b8c-4519-b4ce-a1f3dee7a8bd', 'Overhead Press', 'Shoulders',(SELECT id from equipment WHERE name = 'Dumbbell')),
    ('97ad86bf-df50-4281-9ea6-c29592676575', 'Lateral Raise', 'Shoulders',(SELECT id from equipment WHERE name = 'Dumbbell')),
    ('87e7d230-45b4-44a4-b4b9-e1d70e155c68', 'Face Pull', 'Shoulders'),
    ('09ad3b53-f9fb-4545-b6f1-82b0a34a3d66', 'Bicep Curl', 'Arms',(SELECT id from equipment WHERE name = 'Dumbbell')),
    ('87291e78-dd29-40d1-b0c9-8321689314bd', 'Hammer Curl', 'Arms',(SELECT id from equipment WHERE name = 'Dumbbell')),
    ('ceaeaf0a-7d87-4d3a-835a-80726631f69e', 'Tricep Pushdown', 'Arms'),
    ('93663f52-37b0-47a5-af6f-741766c8f640', 'Skull Crusher', 'Arms',(SELECT id from equipment WHERE name = 'Dumbbell')),
    ('836a4600-e9e0-4b78-a1ee-6abcf346d979', 'Plank', 'Core'),
    ('44a37681-2d0d-4967-b683-25fe4f07b3a7', 'Dead Bug', 'Core'),
    ('1c1169db-7b01-4747-ad06-4158c7111223', 'Bird Dog', 'Core'),
    ('2d0eb458-8f61-4c73-9170-67ab058b0b09', 'Glute Bridge', 'Leg'),
    ('dda38566-05d1-47c8-afa3-6f5e7abab8e3', 'Clamshell', 'Leg'),
    ('a2ca6404-0942-4d9a-9419-ef4ad4c5bd1d', 'Pull-Apart', 'Shoulders'),
    ('2ee40d00-f662-4426-966c-d7c4ff23109f', 'Wall Sit', 'Leg');



