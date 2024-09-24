DROP TABLE IF EXISTS "cypher";

CREATE TABLE IF NOT EXISTS "cypher"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "sentence_nr" NUMERIC NOT NULL,
    "starting" NUMERIC NOT NULL,
    "length" NUMERIC NOT NULL
);

INSERT INTO "cypher" ("sentence_nr","starting","length")
VALUES
    (14,98,4),
    (114,3,5),
    (618,72,9),
    (630,7,3),
    (932,12,5),
    (2230,50,7),
    (2346,44,10),
    (3041,14,5);

CREATE VIEW "message" AS
SELECT substr("sentence","starting","length") AS 'phrase' FROM "cypher"
JOIN "sentences" ON "cypher"."sentence_nr" = "sentences"."id";
