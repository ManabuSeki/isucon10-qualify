ALTER TABLE `isuumo`.`estate` ADD INDEX `popularity_idx` (`popularity`),
ADD COLUMN `geom` geometry NOT NULL,
ADD SPATIAL `geom` (`geom`);
UPDATE `isuumo`.`estate` SET `geom` = ST_GeomFromText(CONCAT('POINT(', `lognitude`, ' ', `latitude`, ')'));
