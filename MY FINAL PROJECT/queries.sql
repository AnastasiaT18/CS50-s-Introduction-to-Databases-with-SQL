 --Add a new singer:
INSERT INTO "singers/bands" ("name", "start_of_activity", "end_of_activity", "main_genre")
VALUES
        ('Faith Hill', '1986-01-01', NULL, 'Country');

--Add a new song:
INSERT INTO "songs" ("title", "genre_id", "singer_id", "release_year","learning_difficulty")
VALUES
        ('Breathe', 1, 1,2000, 'Easy');


-- Find which year is representative for a specific genre (see the year with the most Pop/Hip Hop/Alternative Rock/etc. releases)
WITH "genre_over_the_years" AS(
        SELECT * FROM "full_songs"
        WHERE "name"='Pop')

SELECT "release_year", MAX("nr_of_releases")
FROM (SELECT "release_year", COUNT(*) AS "nr_of_releases"
      FROM "genre_over_the_years"
      GROUP BY "release_year");



-- See which genre is popular in specific year (has the most releases)
WITH "genre_popularity_in_a_year" AS(
        SELECT "name", COUNT(*) AS "nr_of_releases"
        FROM "full_songs"
        WHERE "release_year" = 2001
        GROUP BY "name")

SELECT "name", "nr_of_releases"
FROM "genre_popularity_in_a_year"
WHERE "nr_of_releases" = (SELECT MAX( "nr_of_releases") FROM "genre_popularity_in_a_year");


-- Find what Pop(or any other genre) songs are EASY/MEDIUM/HARD to learn
SELECT * FROM "full_songs"
WHERE "learning_difficulty" = 'Easy' AND "name" = 'Pop';


-- Find all chords in a specific song
SELECT * FROM "songs_and_chords"
WHERE "title" = 'I Knew I Loved You';

--Find the most used chords in a genre
WITH "genre_chords" AS (
        SELECT "song_title","release_year","genres"."name" AS "genre_name","chord_name","tone" FROM "songs_and_chords"
        JOIN "genres" ON "songs_and_chords"."genre_id" = "genres"."id"
        WHERE "genre_name" LIKE '%pop%')

SELECT "chord_name", COUNT(*) AS "nr_of_occurances"
FROM "genre_chords"
GROUP BY "chord_name"
ORDER BY "nr_of_occurances" DESC
LIMIT 4;

-- See years have the easiest(or any difficulty) songs
SELECT "release_year",COUNT(*) AS "nr_of_songs" FROM "songs"
WHERE "learning_difficulty" = 'Easy'
GROUP BY "release_year"
ORDER BY "nr_of_songs" DESC;

---------------------------------------------------

