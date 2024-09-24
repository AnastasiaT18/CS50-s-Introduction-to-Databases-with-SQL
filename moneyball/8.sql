SELECT "salary" FROM "performances"
JOIN "salaries" ON "salaries"."player_id" = "performances"."player_id"
WHERE "HR" = (
    SELECT MAX("HR") FROM "performances"
    WHERE "performances"."year" = 2001
)AND "performances"."year" = 2001
 AND "salaries"."year" = 2001
