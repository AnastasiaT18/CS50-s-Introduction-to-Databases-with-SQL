SELECT "first_name", "last_name" FROM "players"
WHERE "birth_country" != 'USA' AND "birth_country" NOT LIKE 'United States%'
ORDER BY "first_name", "last_name"
