CREATE TABLE "ingredients"(
    "ing_id" NUMERIC,
    "name" TEXT NOT NULL,
    "price_per_unit" NUMERIC NOT NULL,
    PRIMARY KEY("ing_id")
);

CREATE TABLE "donuts"(
    "donut_id" NUMERIC,
    "name" TEXT NOT NULL,
    "gluten_free" TEXT NOT NULL CHECK("gluten_free" IN ('yes','no')),
    "price" NUMERIC NOT NULL,
    PRIMARY KEY("donut_id")
);

CREATE TABLE "donuts_recipe"(
    "donut_id" NUMERIC,
    "ingredient_id" NUMERIC,
    FOREIGN KEY("donut_id") REFERENCES "donuts"("donut_id"),
    FOREIGN KEY("ingredient_id") REFERENCES "ingredients"("ing_id")
);

CREATE TABLE "donuts_orders"(
    "order_id" NUMERIC,
    "donut_id" NUMERIC,
    "amount" INTEGER,
    PRIMARY KEY("order_id","donut_id"),
    FOREIGN KEY("order_id") REFERENCES "orders"("order_id"),
    FOREIGN KEY("donut_id") REFERENCES "donuts"("donut_id")
);

CREATE TABLE "customers"(
    "id" NUMERIC,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "orders"(
    "order_id" NUMERIC,
    "customer_id" NUMERIC,
    PRIMARY KEY("order_id"),
    FOREIGN KEY("customer_id") REFERENCES "customers"("id")
);
