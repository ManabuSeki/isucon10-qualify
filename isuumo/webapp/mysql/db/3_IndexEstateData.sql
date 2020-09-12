ALTER TABLE `isuumo`.`estate` ADD INDEX `popularity_idx` (`popularity`),
ADD COLUMN `geom` geometry;
UPDATE `isuumo`.`estate` SET `geom` = ST_GeomFromText(CONCAT('POINT(', `longitude`, ' ', `latitude`, ')'));
ALTER TABLE `isuumo`.`estate` MODIFY COLUMN `geom` geometry NOT NULL,
ADD SPATIAL `geom` (`geom`);
