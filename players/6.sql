SELECT "first_name", "last_name", "debut" FROM "players"
WHERE "birth_city" = 'Pittsburgh' AND ("birth_state" = 'PA' OR "birth_state" = 'Pennsylvania')
ORDER BY "debut" desc, "first_name", "last_name"
