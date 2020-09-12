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

