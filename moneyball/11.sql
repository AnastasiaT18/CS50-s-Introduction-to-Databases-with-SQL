SELECT "first_name", "last_name", "salary"/"H" AS "dollars per hit" FROM "salaries"
JOIN "performances" ON "salaries"."player_id" = "performances"."player_id" AND "performances"."year"="salaries"."year" AND "performances"."team_id"="salaries"."team_id"
JOIN "players" ON "players"."id" = "performances"."player_id"
WHERE "performances"."year" = 2001
AND "H" <> 0
ORDER BY "dollars per hit", "first_name", "last_name"
LIMIT 10
