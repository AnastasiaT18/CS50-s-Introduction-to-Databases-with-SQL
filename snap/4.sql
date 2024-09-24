
SELECT "username" FROM "users" WHERE "id" = (
SELECT "to_user_id" FROM (
SELECT "to_user_id", MAX("messages_sent_to_user") FROM (
    SELECT "to_user_id", COUNT(*) AS 'messages_sent_to_user' FROM "messages"
    GROUP BY "to_user_id")));
