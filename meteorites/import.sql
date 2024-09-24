DROP TABLE IF EXISTS "meteorites";
DROP TABLE IF EXISTS "temp";

CREATE TABLE "temp"(
    "name" TEXT NOT NULL,
    "id" NUMERIC,
    "nametype" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "mass" NUMERIC,
    "discovery" TEXT NOT NULL,
    "year" NUMERIC,
    "lat" NUMERIC,
    "long" NUMERIC,
    PRIMARY KEY("id")
);

.import --csv --skip 1 meteorites.csv temp

UPDATE "temp" SET "mass" = NULL
WHERE TRIM("mass") = '' OR "mass" IS NULL OR "mass" LIKE ' %' OR "mass" LIKE '% ';

UPDATE "temp" SET "year" = NULL
WHERE TRIM("year") = '' OR "year" IS NULL OR "year" LIKE ' %' OR "year" LIKE '% ';

UPDATE "temp" SET "lat" = NULL
WHERE TRIM("lat") = '';

UPDATE "temp" SET "long" = NULL
WHERE TRIM("long") = '';

UPDATE "temp" SET "mass" = ROUND("mass",2),
    "lat" = ROUND("lat",2),
    "long" = ROUND("long",2);

DELETE FROM "temp" WHERE "nametype" = 'Relict';

--SELECT * FROM "temp"
--ORDER BY "year", "name";

CREATE TABLE IF NOT EXISTS "meteorites"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "mass" NUMERIC,
    "discovery" TEXT NOT NULL CHECK("discovery" IN ('Fell','Found')),
    "year" NUMERIC,
    "lat" NUMERIC,
    "long" NUMERIC
);

INSERT INTO "meteorites" ("name","class","mass","discovery","year","lat","long")
SELECT "name","class","mass","discovery","year","lat","long"
FROM "temp"
ORDER BY "year","name";
