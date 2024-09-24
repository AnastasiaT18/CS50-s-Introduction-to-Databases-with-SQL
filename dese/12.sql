SELECT "name", "per_pupil_expenditure","exemplary" FROM "districts"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
JOIN "staff_evaluations" ON "expenditures"."district_id" = "staff_evaluations"."district_id"
WHERE "per_pupil_expenditure" > (
    SELECT AVG("per_pupil_expenditure") FROM "expenditures")
    AND "exemplary" > (
    SELECT AVG("exemplary") FROM "staff_evaluations")
    AND "type" = 'Public School District'
ORDER BY "exemplary" desc, "per_pupil_expenditure" desc

