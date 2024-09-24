SELECT "Table"."District ID", "Table"."District","Table"."Graduated","exemplary" FROM
    (SELECT "districts"."id" AS "District ID", "districts"."name" AS "District",AVG("graduated") AS "Graduated" FROM "schools"
    JOIN "districts" ON "schools"."district_id" = "districts"."id"
    JOIN "graduation_rates" ON "graduation_rates"."school_id"="schools"."id"
    GROUP BY "District") "Table"
JOIN "staff_evaluations" ON "staff_evaluations"."district_id" = "Table"."District ID"
ORDER BY "exemplary" desc, "Graduated" desc
