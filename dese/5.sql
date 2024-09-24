SELECT "city", COUNT(*) AS "Number" FROM "schools"
WHERE "type" = 'Public School'
GROUP BY "city"
HAVING "Number" <= 3
ORDER BY "Number" desc, "city"
