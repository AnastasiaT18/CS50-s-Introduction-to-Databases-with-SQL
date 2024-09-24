CREATE TABLE `users`(
    `id` INT AUTO_INCREMENT,
   `first_name` VARCHAR(20),
   `last_name` VARCHAR(20),
   `username` VARCHAR(32),
   `password` VARCHAR(32),
   PRIMARY KEY(`id`)
);

ALTER TABLE `users`
MODIFY `first_name` VARCHAR(20) NOT NULL,
MODIFY `last_name` VARCHAR(20) NOT NULL,
MODIFY `username` VARCHAR(32) NOT NULL,
MODIFY `password` VARCHAR(32) NOT NULL;

CREATE TABLE `schools`(
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `type` ENUM('Primary', 'Secondary','Higher Education') NOT NULL,
    `location` VARCHAR(32) NOT NULL,
    `year` INT NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `companies`(
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `industry` ENUM('Technology','Education','Business') NOT NULL,
    `location` VARCHAR(32) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `connections_people`(
    `user_1` INT,
    `user_2` INT,
    FOREIGN KEY(`user_1`) REFERENCES `users`(`id`),
    FOREIGN KEY(`user_2`) REFERENCES `users`(`id`)
);

CREATE TABLE `connections_schools`(
    `user_id` INT,
    `school_id` INT,
    `start_date` DATE NOT NULL ,
    `end_date` DATE NOT NULL,
    `degree_type` VARCHAR(9) NOT NULL,
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`school_id`) REFERENCES `schools`(`id`)
);

ALTER TABLE `connections_schools`
MODIFY `end_date` DATE;

CREATE TABLE `connections_companies`(
    `user_id` INT,
    `company_id` INT,
    `start_date` DATE NOT NULL ,
    `end_date` DATE,
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`company_id`) REFERENCES `companies`(`id`)
);

INSERT INTO `users`(`first_name`,`last_name`,`username`,`password`)
VALUES
    ('Claudine','Gay','claudine','password'),
    ('Reid','Hoffman','reid','password');

INSERT INTO `schools`(`name`,`type`,`location`,`year`)
VALUES
    ('Harvard University','Higher Education','Cambridge, Massachusetts',1636);


INSERT INTO `companies`(`name`,`industry`,`location`)
VALUES
    ('LinkedIn','Technology','Sunnyvale, California');

INSERT INTO `connections_schools`
VALUES
    (1,1,'1993-01-01','1998-12-31','PhD');

ALTER TABLE `connections_companies`
ADD COLUMN `title` VARCHAR(32) NOT NULL;

INSERT INTO `connections_companies`
VALUES
    (2,1,'2003-01-01','2007-02-01','CEO and Chairman');
