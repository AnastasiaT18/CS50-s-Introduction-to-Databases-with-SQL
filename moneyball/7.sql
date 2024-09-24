SELECT "first_name", "last_name" FROM (
        SELECT "player_id" AS "ID", MAX("salary") as Max FROM "salaries")"T"
    JOIN "players" ON "players"."id" = "T"."ID"

