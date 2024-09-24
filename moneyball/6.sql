SELECT "teams"."name", SUM("H") AS "total hits" FROM "performances"
JOIN "teams" ON "performances"."team_id" = "teams"."id"
WHERE "performances"."year" = 2001
GROUP BY "team_id"
ORDER BY "total hits" desc
LIMIT 5
