SELECT "name" FROM "teams"
WHERE "id" IN (
    SELECT "team_id" FROM "players"
    JOIN "performances" ON "players"."id" = "performances"."player_id"
    WHERE "player_id" = (
        SELECT "id" FROM "players"
        WHERE "first_name" = 'Satchel' AND "last_name" = "Paige")
)


