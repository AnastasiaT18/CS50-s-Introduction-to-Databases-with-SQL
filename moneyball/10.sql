SELECT distinct "first_name", "last_name", "salary","salaries"."year", "HR" FROM "players"
JOIN "salaries" ON "players"."id" = "salaries"."player_id"
JOIN "performances" ON "salaries"."player_id" = "performances"."player_id" AND "salaries"."year" = "performances"."year"
ORDER BY "players"."id", "salaries"."year" desc, "HR" desc, "salary" desc
