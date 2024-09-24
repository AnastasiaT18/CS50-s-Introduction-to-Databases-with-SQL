-- Drop existing tables to ensure a clean slate
DROP TABLE IF EXISTS "chords_in_song";
DROP TABLE IF EXISTS "songs";
DROP TABLE IF EXISTS "guitar_chords";
DROP TABLE IF EXISTS "genres";
DROP TABLE IF EXISTS "singers/bands";

-- DROP VIEW IF EXISTS "full_songs";
-- DROP VIEW IF EXISTS "songs_and_chords";

-- Drop indexes to recreate them based on the current structure
DROP INDEX IF EXISTS "genres_name";
DROP INDEX IF EXISTS "learn";
DROP INDEX IF EXISTS "chords_finder";
DROP INDEX IF EXISTS "song_title";
DROP INDEX IF EXISTS "song_release_year";

-- Clean up the database storage (optional but recommended for optimization)
VACUUM;

-------TABLES-------

-- Represent the singers/bands (stores basic information about artists)
  CREATE TABLE IF NOT EXISTS "singers/bands"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "start_of_activity" DATE NOT NULL,
    "end_of_activity" DATE,
    "main_genre" TEXT NOT NULL
);

-- Represents musical genres and their description
CREATE TABLE IF NOT EXISTS "genres"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT UNIQUE NOT NULL,
    "description" TEXT NOT NULL
);

-- Represents guitar chords and information about them
CREATE TABLE IF NOT EXISTS "guitar_chords"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "tone" NOT NULL CHECK ("tone" IN ('Major', 'Minor', 'Diminished', 'Augmented', 'Suspended', 'Dominant')),
    "difficulty" NOT NULL CHECK("difficulty" IN ('Easy', 'Medium', 'Hard'))
);

-- Represents songs
CREATE TABLE IF NOT EXISTS "songs"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "genre_id" INTEGER NOT NULL,
    "singer_id" INTEGER NOT NULL,
    "release_year" INTEGER NOT NULL,
    "learning_difficulty" TEXT NOT NULL CHECK("learning_difficulty" in ('Easy', 'Medium', 'Hard')),
    FOREIGN KEY("genre_id") REFERENCES "genres"("id"),
    FOREIGN KEY("singer_id") REFERENCES "singers/bands"("id")
);

-- Represents a mapping table to relate songs and the guitar chords used in them (many-to-many relationship)
CREATE TABLE IF NOT EXISTS "chords_in_song"(
    "song_id" INTEGER,
    "chord_id" INTEGER,
    FOREIGN KEY ("song_id") REFERENCES "songs"("id"),
    FOREIGN KEY ("chord_id") REFERENCES "guitar_chords"("id")
);

------VIEWS-------

-- Represents a view that shows song details including the title, release year, genre name, and learning difficulty
CREATE VIEW "full_songs" AS
SELECT "title","release_year","name","learning_difficulty" FROM "songs"
JOIN "genres" WHERE "songs"."genre_id" = "genres"."id";

-- Represents a view that shows song and chord details, including song title, id, release year, genre id, chord name, and tone
CREATE VIEW "songs_and_chords" AS
SELECT "songs"."id" AS "song_id","title" AS "song_title","release_year","genre_id","name" AS "chord_name","tone" FROM "songs"
JOIN "chords_in_song" ON "songs"."id" = "song_id"
JOIN "guitar_chords" ON "chord_id" = "guitar_chords"."id";

-----INDEXES-----
--Represent indexes to optimize search
CREATE INDEX "genres_name" ON "genres" ("name");
CREATE INDEX "chords_finder" ON "chords_in_song"("chord_id");
CREATE INDEX "learn" ON "songs"("learning_difficulty");
CREATE INDEX "song_title" ON "songs"("title");
CREATE INDEX "song_release_year" ON "songs"("release_year");

-------DATA INSERTION (the data I worked with)-------

-- INSERT INTO "singers/bands" ("name", "start_of_activity", "end_of_activity", "main_genre")
-- VALUES
--     --2000
--     ('Faith Hill', '1986-01-01', NULL, 'Country'),
--     ('Santana', '1966-01-01', NULL, 'Rock/Latin Rock'),
--     ('The Product G&B', '1998-01-01', NULL, 'Latin Rock'),
--     ('Joe', '1993-01-01', NULL, 'R&B'),
--     ('Vertical Horizon', '1991-01-01', NULL, 'Alternative Rock'),
--     ('Destiny''s Child', '1990-01-01', '2006-01-01', 'R&B'),
--     ('Savage Garden', '1993-01-01', '2001-01-01', 'Pop'),
--     ('Lonestar', '1992-01-01', NULL, 'Country'),
--     ('Matchbox Twenty', '1995-01-01', NULL, 'Alternative Rock'),
--     ('Sisqó', '1999-01-01', NULL, 'R&B'),
--     --2001
--     ('Alicia Keys', '2001-01-01', NULL, 'R&B'),
--     ('OutKast', '1992-01-01', NULL, 'Hip Hop'),
--     ('Shaggy', '1993-01-01', NULL, 'Reggae'),
--     ('Jennifer Lopez', '1999-01-01', NULL, 'Pop'),
--     ('Nelly', '2000-01-01', NULL, 'Hip Hop'),
--     ('Linkin Park', '1996-01-01', NULL, 'Nu Metal'),
--     ('Usher', '1994-01-01', NULL, 'R&B'),
--     ('Missy Elliott', '1997-01-01', NULL, 'Hip Hop'),
--     ('N''Sync', '1995-01-01', NULL, 'Pop'),
--     ('Britney Spears', '1998-01-01', NULL, 'Pop'),

--     -- 2002
--     ('Eminem', '1996-01-01', NULL, 'Hip Hop'),
--     ('Vanessa Carlton', '2001-01-01', NULL, 'Pop'),
--     ('Avril Lavigne', '2002-01-01', NULL, 'Pop Punk'),
--     ('Ashanti', '2001-01-01', NULL, 'R&B'),
--     ('Shakira', '1990-01-01', NULL, 'Pop/Latin'),
--     ('Jimmy Eat World', '1993-01-01', NULL, 'Alternative Rock'),
--     ('Puddle of Mudd', '1991-01-01', NULL, 'Post-Grunge'),

--     -- 2003
--     ('50 Cent', '1998-01-01', NULL, 'Hip Hop'),
--     ('Beyoncé', '1997-01-01', NULL, 'Pop/R&B'),
--     ('Evanescence', '1995-01-01', NULL, 'Rock/Alternative Rock'),
--     ('Sean Paul', '1996-01-01', NULL, 'Dancehall'),
--     ('Pink', '1995-01-01', NULL, 'Pop Rock'),
--     ('Christina Aguilera', '1999-01-01', NULL, 'Pop'),
--     ('OutKast', '1992-01-01', NULL, 'Hip Hop'),
--     ('The White Stripes', '1997-01-01', NULL, 'Rock/Alternative Rock'),
--     ('The Black Eyed Peas', '1995-01-01', NULL, 'Hip Hop');


-- INSERT INTO "genres" ("name", "description")
-- VALUES
--     ('Country', 'A genre of popular music that originated with blues, church music, and American folk music.'),
--     ('Rock/Latin Rock', 'A fusion genre combining elements of rock music and Latin American music.'),
--     ('Latin Rock', 'A subgenre of rock music that includes a strong Latin American influence.'),
--     ('R&B', 'Rhythm and blues, a genre that combines elements of jazz, blues, and gospel music.'),
--     ('Alternative Rock', 'A genre of rock music that emerged from the independent music underground of the 1980s and became widely popular in the 1990s and 2000s.'),
--     ('Pop', 'A genre of popular music that originated in its modern form during the mid-1950s. Popular music tends to have an emphasis on catchy melodies.'),
--     ('Rock', 'A genre of popular music that originated as "rock and roll" in the United States in the 1950s and developed into a range of different styles.'),
--     ('Pop Rock', 'A subgenre of pop music that combines a catchy pop style and light lyrics with guitar-based rock sounds.'),
--     ('Hip Hop', 'A genre of popular music that originated in the 1970s in the Bronx, New York, characterized by rhythmic vocal style and a focus on beat and rhythm.'),
--     ('Reggae', 'A genre of music that originated in Jamaica in the late 1960s, characterized by a rhythmic style and socially conscious lyrics.'),
--     ('Nu Metal', 'A subgenre of alternative metal that blends heavy metal with other genres like hip hop, grunge, and industrial.'),
--     ('Pop Punk', 'A fusion genre that combines the energy and rebellious attitude of punk rock with catchy, pop-style melodies.'),
--     ('Pop/Latin', 'A genre that blends elements of Latin American music with mainstream pop.'),
--     ('Post-Grunge', 'A genre of rock music that emerged as a more commercial and radio-friendly version of grunge, typically featuring a cleaner sound.'),
--     ('Dancehall', 'A genre of Jamaican popular music that originated in the late 1970s, characterized by its upbeat rhythms and socially conscious lyrics.'),
--     ('Rock/Alternative Rock', 'A genre that combines elements of rock and alternative rock, often with a focus on guitar-driven sounds and introspective lyrics.');


-- INSERT INTO "guitar_chords" ("name", "tone", "difficulty")
-- VALUES
--     ('G Major', 'Major', 'Easy'),
--     ('C Major', 'Major', 'Easy'),
--     ('D Major', 'Major', 'Easy'),
--     ('A Minor', 'Minor', 'Medium'),
--     ('E Minor', 'Minor', 'Easy'),
--     ('F Major', 'Major', 'Hard'),
--     ('B Minor', 'Minor', 'Medium'),
--     ('E Major', 'Major', 'Easy'),
--     ('A Major', 'Major', 'Easy'),
--     ('G5', 'Major', 'Easy'),
--     ('D5', 'Major', 'Easy'),
--     ('Dsus4', 'Suspended', 'Medium'),
--     ('Gsus4', 'Suspended', 'Medium'),
--     ('Bdim', 'Diminished', 'Hard'),
--     ('Adim', 'Diminished', 'Hard'),
--     ('Caug', 'Augmented', 'Hard'),
--     ('Eaug', 'Augmented', 'Hard'),
--     ('G7', 'Major', 'Medium'),
--     ('C7', 'Major', 'Medium'),
--     ('D7', 'Major', 'Medium'),
--     ('Am7', 'Minor', 'Medium'),
--     ('Dm7', 'Minor', 'Medium'),
--     ('CMaj7', 'Major', 'Medium'),
--     ('GMaj7', 'Major', 'Medium'),
--     ('C9', 'Major', 'Hard'),
--     ('G13', 'Major', 'Hard'),
--     ('D7sus4', 'Suspended', 'Medium'),
--     ('Asus2', 'Suspended', 'Medium'),
--     ('C5', 'Major', 'Easy'),
--     ('A5', 'Major', 'Easy');



-- INSERT INTO "songs" ("title", "genre_id", "singer_id", "release_year","learning_difficulty")
-- VALUES
--     --2000
--     ('Breathe', 1, 1,2000, 'Easy'),  -- Faith Hill, Country
--     ('Smooth', 2, 2,2000, 'Medium'),  -- Santana, Rock/Latin Rock
--     ('Maria Maria', 3, 2,2000, 'Medium'),  -- Santana, Latin Rock
--     ('I Wanna Know', 4, 4,2000, 'Medium'),  -- Joe, R&B
--     ('Everything You Want', 5, 5,2000, 'Medium'),  -- Vertical Horizon, Alternative Rock
--     ('Say My Name', 4, 6,2000, 'Hard'),  -- Destiny's Child, R&B
--     ('I Knew I Loved You', 6, 7,2000, 'Easy'),  -- Savage Garden, Pop
--     ('Amazed', 1, 8,2000, 'Medium'),  -- Lonestar, Country
--     ('Bent', 5, 9,2000, 'Medium'),  -- Matchbox Twenty, Alternative Rock
--     ('Thong Song', 4, 10,2000, 'Hard'),  -- Sisqó, R&B
--     --2001
--     ('Fallin', 4, 11, 2001, 'Medium'),  -- Alicia Keys, R&B
--     ('Ms. Jackson', 9, 12, 2001, 'Medium'),  -- OutKast, Hip Hop
--     ('It Wasn''t Me', 9, 13, 2001, 'Easy'),  -- Shaggy, Hip Hop
--     ('Get the Party Started', 6, 14, 2001, 'Medium'),  -- Jennifer Lopez, Pop
--     ('In Da Club', 9, 15, 2001, 'Hard'),  -- Nelly, Hip Hop
--     ('Bring Me to Life', 11, 16, 2001, 'Hard'),  -- Linkin Park, Nu Metal
--     ('Hot in Herre', 9, 15, 2001, 'Medium'),  -- Nelly, Hip Hop
--     ('All the Things I Should Have Known', 6, 20, 2001, 'Medium'),  -- N''Sync, Pop
--     ('I''m a Slave 4 U', 6, 20, 2001, 'Medium'),  -- Britney Spears, Pop
--     ('Hips Don''t Lie', 10, 13, 2001, 'Easy'), -- Shakira, Reggae
--     --2002
--     ('Lose Yourself', 9, 21, 2002, 'Hard'),  -- Eminem, Hip Hop
--     ('A Thousand Miles', 6, 22, 2002, 'Medium'),  -- Vanessa Carlton, Pop
--     ('Complicated', 12, 23, 2002, 'Medium'),  -- Avril Lavigne, Pop Punk
--     ('Foolish', 4, 24, 2002, 'Medium'),  -- Ashanti, R&B
--     ('Whenever, Wherever', 13, 25, 2002, 'Easy'),  -- Shakira, Pop/Latin
--     ('Hot in Herre', 9, 15, 2002, 'Medium'),  -- Nelly, Hip Hop
--     ('The Middle', 5, 26, 2002, 'Medium'),  -- Jimmy Eat World, Alternative Rock
--     ('Dilemma', 9, 15, 2002, 'Medium'),  -- Nelly ft. Kelly Rowland, Hip Hop
--     ('Blurry', 14, 27, 2002, 'Hard'),  -- Puddle of Mudd, Post-Grunge
--     ('The Game of Love', 2, 2, 2002, 'Medium'),  -- Santana, Rock/Latin Rock
--     --2003
--     ('In Da Club', 9, 28, 2003, 'Medium'),  -- 50 Cent, Hip Hop
--     ('Crazy in Love', 4, 29, 2003, 'Medium'),  -- Beyoncé, Pop/R&B
--     ('Bring Me to Life', 5, 30, 2003, 'Hard'),  -- Evanescence, Rock/Alternative Rock
--     ('Get Busy', 10, 31, 2003, 'Medium'),  -- Sean Paul, Dancehall
--     ('Just Like a Pill', 6, 32, 2003, 'Medium'),  -- Pink, Pop Rock
--     ('Beautiful', 4, 33, 2003, 'Easy'),  -- Christina Aguilera, Pop
--     ('Hey Ya!', 9, 34, 2003, 'Medium'),  -- OutKast, Hip Hop
--     ('Seven Nation Army', 5, 35, 2003, 'Medium'),  -- The White Stripes, Rock/Alternative Rock
--     ('Where Is the Love?', 12, 36, 2003, 'Medium'); -- The Black Eyed Peas, Hip Hop


-- INSERT INTO "chords_in_song" ("song_id", "chord_id")
-- VALUES
--     -- "Breathe"
--     (1, 1),  -- G Major
--     (1, 2),  -- C Major
--     (1, 3),  -- D Major
--     (1, 5),  -- E Minor

--     -- "Smooth"
--     (2, 4),  -- A Minor
--     (2, 5),  -- E Minor
--     (2, 6),  -- F Major
--     (2, 1),  -- G Major

--     -- "Maria Maria"
--     (3, 2),  -- C Major
--     (3, 1),  -- G Major
--     (3, 4),  -- A Minor

--     -- "I Wanna Know"
--     (4, 5),  -- E Minor
--     (4, 7),  -- B Minor
--     (4, 8),  -- E Major

--     -- "Everything You Want"
--     (5, 1),  -- G Major
--     (5, 3),  -- D Major
--     (5, 6),  -- F Major

--     -- "Say My Name"
--     (6, 1),  -- G Major
--     (6, 2),  -- C Major
--     (6, 4),  -- A Minor
--     (6, 5),  -- E Minor

--     -- "I Knew I Loved You"
--     (7, 2),  -- C Major
--     (7, 4),  -- A Minor
--     (7, 8),  -- E Major

--     -- "Amazed"
--     (8, 1),  -- G Major
--     (8, 2),  -- C Major
--     (8, 5),  -- E Minor

--     -- "Bent"
--     (9, 3),  -- D Major
--     (9, 6),  -- F Major
--     (9, 1),  -- G Major

--     -- "Thong Song"
--     (10, 4), -- A Minor
--     (10, 6), -- F Major
--     (10, 5), -- E Minor

-- -- "Fallin"
--     (11, 3),  -- D Major
--     (11, 7),  -- B Minor
--     (11, 8),  -- E Major

--     -- "Ms. Jackson"
--     (12, 4),  -- A Minor
--     (12, 7),  -- B Minor
--     (12, 8),  -- E Major

--     -- "It Wasn't Me"
--     (13, 1),  -- G Major
--     (13, 2),  -- C Major
--     (13, 5),  -- E Minor

--     -- "Get the Party Started"
--     (14, 2),  -- C Major
--     (14, 4),  -- A Minor
--     (14, 1),  -- G Major

--     -- "In Da Club"
--     (15, 6),  -- F Major
--     (15, 4),  -- A Minor
--     (15, 3),  -- D Major

--     -- "Bring Me to Life"
--     (16, 6),  -- F Major
--     (16, 3),  -- D Major
--     (16, 7),  -- B Minor

--     -- "Hot in Herre"
--     (17, 4),  -- A Minor
--     (17, 8),  -- E Major
--     (17, 7),  -- B Minor

--     -- "All the Things I Should Have Known"
--     (18, 2),  -- C Major
--     (18, 6),  -- F Major
--     (18, 4),  -- A Minor

--     -- "I'm a Slave 4 U"
--     (19, 1),  -- G Major
--     (19, 2),  -- C Major
--     (19, 4),  -- A Minor

--     -- "Hips Don't Lie"
--     (20, 1),  -- G Major
--     (20, 2),  -- C Major
--     (20, 5),  -- E Minor

-- --2002
-- -- For "Lose Yourself"
--     (21, 1),  -- G Major
--     (21, 4),  -- A Minor
--     (21, 7),  -- B Minor

-- -- For "A Thousand Miles"
--     (22, 1),  -- G Major
--     (22, 2),  -- C Major
--     (22, 4),  -- A Minor
--     (22, 5),  -- E Minor

-- -- For "Complicated"
--     (23, 1),  -- G Major
--     (23, 2),  -- C Major
--     (23, 4),  -- A Minor
--     (23, 5),  -- E Minor

-- -- For "Foolish"
--     (24, 1),  -- G Major
--     (24, 2),  -- C Major
--     (24, 4),  -- A Minor
--     (24, 5),  -- E Minor

-- -- For "Whenever, Wherever"
--     (25, 1),  -- G Major
--     (25, 2),  -- C Major
--     (25, 4),  -- A Minor
--     (25, 5),  -- E Minor

-- -- For "Hot in Herre"
--     (26, 1),  -- G Major
--     (26, 2),  -- C Major
--     (26, 4),  -- A Minor
--     (26, 5),  -- E Minor

-- -- For "The Middle"
--     (27, 1),  -- G Major
--     (27, 2),  -- C Major
--     (27, 4),  -- A Minor
--     (27, 5),  -- E Minor

-- -- For "Dilemma"
--     (28, 1),  -- G Major
--     (28, 2),  -- C Major
--     (28, 4),  -- A Minor
--     (28, 5),  -- E Minor

-- -- For "Blurry"
--     (29, 6),  -- F Major
--     (29, 7),  -- B Minor
--     (29, 8),  -- E Major

-- -- For "The Game of Love"
--     (30, 1),  -- G Major
--     (30, 2),  -- C Major
--     (30, 4),  -- A Minor
--     (30, 5),  -- E Minor

-- --2003
--     -- "In Da Club" (50 Cent)
--     (31, 1),  -- G Major
--     (31, 2),  -- C Major
--     (31, 4),  -- A Minor
--     (31, 5),  -- E Minor
--     (31, 10), -- G5
--     (31, 11), -- D5

--     -- "Crazy in Love" (Beyoncé)
--     (32, 1),  -- G Major
--     (32, 2),  -- C Major
--     (32, 4),  -- A Minor
--     (32, 6),  -- F Major
--     (32, 9),  -- A Major
--     (32, 10), -- G5

--     -- "Bring Me to Life" (Evanescence)
--     (33, 1),  -- G Major
--     (33, 2),  -- C Major
--     (33, 3),  -- D Major
--     (33, 4),  -- A Minor
--     (33, 5),  -- E Minor
--     (33, 6),  -- F Major
--     (33, 13), -- G13
--     (33, 14), -- C9
--     (33, 15), -- D7

--     -- "Get Busy" (Sean Paul)
--     (34, 1),  -- G Major
--     (34, 2),  -- C Major
--     (34, 4),  -- A Minor
--     (34, 5),  -- E Minor
--     (34, 10), -- G5
--     (34, 11), -- D5

--     -- "Just Like a Pill" (Pink)
--     (35, 1),  -- G Major
--     (35, 2),  -- C Major
--     (35, 4),  -- A Minor
--     (35, 5),  -- E Minor
--     (35, 6),  -- F Major
--     (35, 9),  -- A Major

--     -- "Beautiful" (Christina Aguilera)
--     (36, 1),  -- G Major
--     (36, 2),  -- C Major
--     (36, 4),  -- A Minor
--     (36, 5),  -- E Minor
--     (36, 9),  -- A Major

--     -- "Hey Ya!" (OutKast)
--     (37, 1),  -- G Major
--     (37, 2),  -- C Major
--     (37, 4),  -- A Minor
--     (37, 5),  -- E Minor
--     (37, 10), -- G5

--     -- "Seven Nation Army" (The White Stripes)
--     (38, 1),  -- G Major
--     (38, 5),  -- E Minor
--     (38, 11), -- D5

--     -- "Where Is the Love?" (The Black Eyed Peas)
--     (39, 1),  -- G Major
--     (39, 2),  -- C Major
--     (39, 4),  -- A Minor
--     (39, 5),  -- E Minor
--     (39, 10), -- G5
--     (39, 11);  -- D5
