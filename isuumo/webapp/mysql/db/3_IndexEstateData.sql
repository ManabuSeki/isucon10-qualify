ALTER TABLE `isuumo`.`estate` ADD INDEX `popularity_idx` (`popularity`),
CREATE TABLE IF NOT EXISTS `isuumo`.`geotable` (
  `id`   INTEGER NOT NULL,
  `geom` geometry NOT NULL,
  PRIMARY KEY (`id`),
  SPATIAL KEY `geom` (`geom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT INTO `isuumo`.`geotable` SELECT `id`, ST_GeomFromText(CONCAT('POINT(', `longitude`, ' ', `latitude`, ')')) 
FROM `issumo`.`estate`;

