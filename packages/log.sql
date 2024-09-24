
-- *** The Lost Letter ***
SELECT "id","address","type" FROM "addresses" --this query returns the address(id,name,type) where package was dropped
WHERE "id" = (
    SELECT "address_id" FROM "scans" --this query finds where package was dropped
    WHERE "package_id" = (
        SELECT "id" FROM "packages" --this query finds id of package which was sent from 900 Somerville Avenue
        WHERE "from_address_id" =
            (SELECT "id" FROM "addresses" -- this query finds id of address 900 Somerville Avenue
             WHERE "address" = '900 Somerville Avenue')
             AND "contents" LIKE 'congratulatory%')
    AND "action" = 'Drop');

-- *** The Devious Delivery ***
SELECT "contents","addresses"."id", "addresses"."address","type" FROM "packages"
JOIN "scans" ON "packages"."id" = "scans"."package_id"
JOIN "addresses" ON "addresses"."id" = "scans"."address_id"
WHERE "from_address_id" IS NULL
AND "action" = 'Drop';
-- I joined all three tables "packages", "scans" and "addresses" to find the package
--with a NULL "from_address_id" and a "Drop" action. Then, selected the columns I want to be returned


-- *** The Forgotten Gift ***

SELECT "contents","drivers"."name",MAX("timestamp") as "Latest" FROM "packages"
JOIN "scans" ON "packages"."id" = "scans"."package_id"
JOIN "drivers" ON "scans"."driver_id" = "drivers"."id"
WHERE "from_address_id" =
    (SELECT "id" FROM "addresses"
     WHERE "address" = '109 Tileston Street')
AND "to_address_id" =
    (SELECT "id" FROM "addresses"
     WHERE "address" = '728 Maple Place');
-- I joined all three tables "packages","scans" and "drivers" to find the latest scan of package sent from  109 Tileston Street
-- to 728 Maple Place, and afterwards get the name of the driver who has it.

