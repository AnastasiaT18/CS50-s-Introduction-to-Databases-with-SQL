SELECT "city", COUNT(*) AS "Number" FROM "schools"
WHERE "type" = 'Public School'
GROUP BY "city"
ORDER BY "Number" desc, "city"
LIMIT 10
