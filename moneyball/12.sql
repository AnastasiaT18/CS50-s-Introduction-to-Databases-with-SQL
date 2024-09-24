SELECT "first_name", "last_name" FROM
(SELECT "first_name", "last_name" FROM "salaries"
JOIN "performances" ON "salaries"."player_id" = "performances"."player_id" AND "performances"."year"="salaries"."year" AND "performances"."team_id"="salaries"."team_id"
JOIN "players" ON "players"."id" = "performances"."player_id"
WHERE "performances"."year" = 2001
AND "H" <> 0
ORDER BY  "salary"/"H", "players"."id"
LIMIT 10)

INTERSECT
SELECT "first_name", "last_name" FROM
(
SELECT "first_name", "last_name" FROM "salaries"
JOIN "performances" ON "salaries"."player_id" = "performances"."player_id" AND "performances"."year"="salaries"."year" AND "performances"."team_id"="salaries"."team_id"
JOIN "players" ON "players"."id" = "performances"."player_id"
WHERE "performances"."year" = 2001
AND "RBI" <> 0
ORDER BY  "salary"/"RBI", "players"."id"
LIMIT 10)
ORDER BY "last_name"
