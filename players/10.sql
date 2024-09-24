
SELECT "first_name" AS "First Name","last_name" AS "Last Name", "height" FROM "players"
WHERE "height" > (SELECT AVG("height") FROM "players")
ORDER BY "height" desc, "first_name", "last_name"
