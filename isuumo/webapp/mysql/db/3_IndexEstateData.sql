ALTER TABLE `isuumo`.`estate` ADD INDEX `popularity_idx` (`popularity`), ADD INDEX `rent_idx` (`rent`);
ALTER TABLE `isuumo`.`chair` ADD INDEX `popularity_idx` (`popularity`), ADD INDEX `price_idx` (`price`);
CREATE TABLE IF NOT EXISTS `isuumo`.`geotable` (
  `id`   INTEGER NOT NULL,
  `geom` geometry NOT NULL,
  PRIMARY KEY (`id`),
  SPATIAL KEY `geom` (`geom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE IF NOT EXISTS `isuumo`.`low_priced_estate` (
    id          INTEGER             NOT NULL PRIMARY KEY,
    name        VARCHAR(64)         NOT NULL,
    description VARCHAR(4096)       NOT NULL,
    thumbnail   VARCHAR(128)        NOT NULL,
    address     VARCHAR(128)        NOT NULL,
    latitude    DOUBLE PRECISION    NOT NULL,
    longitude   DOUBLE PRECISION    NOT NULL,
    rent        INTEGER             NOT NULL,
    door_height INTEGER             NOT NULL,
    door_width  INTEGER             NOT NULL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL
) ENGINE=InnoDB;
INSERT INTO `isuumo`.`geotable` SELECT `id`, ST_GeomFromText(CONCAT('POINT(', `latitude`, ' ', `longitude`, ')')) 
FROM `isuumo`.`estate`;
INSERT INTO `isuumo`.`low_priced_estate` SELECT * FROM `isuumo`.`estate` ORDER BY rent ASC, id ASC LIMIT 20;
CREATE TABLE IF NOT EXISTS `isuumo`.`rent_range_id_cache` (
  `id`   INTEGER NOT NULL,
  `count` INTEGER NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
INSERT INTO `isuumo`.`rent_range_id_cache` SELECT 0, COUNT(*) FROM `isuumo`.`estate` WHERE rent < 50000;
INSERT INTO `isuumo`.`rent_range_id_cache` SELECT 1, COUNT(*) FROM `isuumo`.`estate` WHERE 50000 <= rent AND rent < 100000;
INSERT INTO `isuumo`.`rent_range_id_cache` SELECT 2, COUNT(*) FROM `isuumo`.`estate` WHERE 100000 <= rent AND rent < 150000;
INSERT INTO `isuumo`.`rent_range_id_cache` SELECT 3, COUNT(*) FROM `isuumo`.`estate` WHERE 150000 <= rent;
CREATE TABLE IF NOT EXISTS `isuumo`.`estate_rent_range` (
  `estate_id`   INTEGER NOT NULL,
  `rent_range_id` INTEGER NOT NULL,
  `popularity` INTEGER  NOT NULL,
  PRIMARY KEY (`estate_id`)
) ENGINE=InnoDB;
INSERT INTO `isuumo`.`estate_rent_range` SELECT id, 0 FROM `isuumo`.`estate` WHERE rent < 50000;
INSERT INTO `isuumo`.`estate_rent_range` SELECT id, 1 FROM `isuumo`.`estate` WHERE 50000 <= rent AND rent < 100000;
INSERT INTO `isuumo`.`estate_rent_range` SELECT id, 2 FROM `isuumo`.`estate` WHERE 100000 <= rent AND rent < 150000;
INSERT INTO `isuumo`.`estate_rent_range` SELECT id, 3 FROM `isuumo`.`estate` WHERE 150000 <= rent;
ALTER TABLE `isuumo`.`estate_rent_range` ADD INDEX `rent_range_id_popularity_idx` (`rent_range_id`, `popularity`);



