CREATE INDEX "enrollments_student_id3" ON "enrollments" ("student_id","course_id");
CREATE INDEX "course_data" ON "courses" ("department","number","semester");
CREATE INDEX "enrollment_2" ON "enrollments"("course_id");
CREATE INDEX "course_index" ON "courses"("semester");
CREATE INDEX "satisfies_index" ON "satisfies"("course_id","requirement_id");
