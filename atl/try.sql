SELECT "airlines"."name","concourses"."concourse" FROM "airlines"
JOIN "airlines_concourses" ON "airlines"."id" = "airlines_concourses"."airline_id"
JOIN "concourses" ON "airlines_concourses"."concourse_id" = "concourses"."id"
