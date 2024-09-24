CREATE TABLE "users"(
    "id" NUMERIC,
    "first_name" TEXT,
    "last_name" TEXT,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "schools"(
    "id" NUMERIC,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "year" NUMERIC,
    PRIMARY KEY("id")
);

CREATE TABLE "companies"(
    "id" NUMERIC,
    "name" TEXT NOT NULL,
    "industry" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "connections_people"(
    "user_1" NUMERIC NOT NULL,
    "user_2" NUMERIC NOT NULL,
    FOREIGN KEY("user_1") REFERENCES "users"("id"),
    FOREIGN KEY("user_2") REFERENCES "users"("id")
);

CREATE TABLE "connections_schools"(
    "user" NUMERIC,
    "school_id" NUMERIC,
    "start" DATE NOT NULL,
    "end" DATE,
    "degree" TEXT NOT NULL,
    FOREIGN KEY("user") REFERENCES "users"("id"),
    FOREIGN KEY("school_id") REFERENCES "schools"("id")
);

CREATE TABLE "connections_companies"(
    "user" NUMERIC,
    "company_id" NUMERIC,
    "start" DATE NOT NULL,
    "end" DATE,
    "title" TEXT NOT NULL,
    FOREIGN KEY("user") REFERENCES "users"("id"),
    FOREIGN KEY("company_id") REFERENCES "companies"("id")
);
