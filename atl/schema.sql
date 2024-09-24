CREATE TABLE "passengers"(
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    PRIMARY KEY ("id")
    );

CREATE TABLE "check_ins"(
    "passenger_id" NUMERIC NOT NULL,
    "datetime" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "flight_id" NUMERIC NOT NULL,
    FOREIGN KEY("passenger_id") REFERENCES "passengers"("id"),
    FOREIGN KEY("flight_id") REFERENCES "flights"("flight_id")
);

CREATE TABLE "flights"(
    "flight_id" NUMERIC,
    "flight_number" NUMERIC NOT NULL,
    "airline_id" NUMERIC,
    "departing_from_airport" TEXT NOT NULL,
    "heading_to_airport" TEXT NOT NULL,
    "expected_departure" TIMESTAMP NOT NULL,
    "expected_arrival" TIMESTAMP NOT NULL,
    PRIMARY KEY("flight_id"),
    FOREIGN KEY("airline_id") REFERENCES "airlines"("id")
);

CREATE TABLE "airlines"(
    "id" NUMERIC,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "concourses"(
    "id" NUMERIC,
    "concourse" TEXT,
    PRIMARY KEY("id")
);

CREATE TABLE "airlines_concourses"(
    "airline_id" NUMERIC,
    "concourse_id" NUMERIC,
    FOREIGN KEY("airline_id") REFERENCES "airlines"("id"),
    FOREIGN KEY("concourse_id") REFERENCES "concourses"("id")
);

