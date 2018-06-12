CREATE DATABASE `20161_Service_G4`;
USE `20161_Service_G4`;
CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `dni` int(11) NOT NULL,
  `telefono` int(11) NOT NULL,
  `mail` varchar(45) NOT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `altura` int(11) DEFAULT NULL,
  `piso` int(11) DEFAULT NULL,
  `dpto` varchar(2) DEFAULT NULL,
  `localidad` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`,`dni`),
  UNIQUE KEY `dni_UNIQUE` (`dni`)
);

CREATE TABLE `estado` (
  `idestado` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idestado`,`nombre`)
);

CREATE TABLE `marca` (
  `idmarca` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idmarca`,`nombre`)
);

CREATE TABLE `tipo_producto` (
  `idtipo_producto` int(11) NOT NULL AUTO_INCREMENT,
  `id_marca` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idtipo_producto`),
  KEY `id_marca_idx` (`id_marca`),
  CONSTRAINT `id_marca` FOREIGN KEY (`id_marca`) REFERENCES `marca` (`idmarca`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `orden_trabajo` (
  `idorden_trabajo` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `detalle` varchar(45) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `nro_serie` varchar(45) DEFAULT NULL,
  `envio` binary(1) DEFAULT NULL,
  `entregado` binary(1) DEFAULT NULL,
  PRIMARY KEY (`idorden_trabajo`),
  KEY `idcliente_idx` (`id_cliente`),
  KEY `idproducto_idx` (`id_producto`),
  KEY `idestado_idx` (`id_estado`),
  CONSTRAINT `idcliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idestado` FOREIGN KEY (`id_estado`) REFERENCES `estado` (`idestado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idproducto` FOREIGN KEY (`id_producto`) REFERENCES `tipo_producto` (`idtipo_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `repuesto` (
  `idrepuesto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `id_marca_repuesto` int(11) NOT NULL,
  `costo` double NOT NULL,
  `precio` double NOT NULL,
  `stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`idrepuesto`,`nombre`,`id_marca_repuesto`),
  KEY `id_marca_idx` (`id_marca_repuesto`),
  CONSTRAINT `id_marca_repuesto` FOREIGN KEY (`id_marca_repuesto`) REFERENCES `marca` (`idmarca`) ON DELETE NO ACTION ON UPDATE NO ACTION
);


CREATE TABLE `presupuesto` (
  `idpresupuesto` int(11) NOT NULL AUTO_INCREMENT,
  `id_ot` int(11) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `desperfecto` varchar(45) NOT NULL,
  `id_estado` int(11) DEFAULT NULL,
  `horas` int(11) NOT NULL,
  `costo` double NOT NULL,
  `id_producto` int(11) NOT NULL,
  PRIMARY KEY (`idpresupuesto`),
  KEY `id_ot_idx` (`id_ot`),
  KEY `id_estado_idx` (`id_estado`),
  KEY `id_producto_idx` (`id_producto`),
  CONSTRAINT `id_estado` FOREIGN KEY (`id_estado`) REFERENCES `estado` (`idestado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_ot` FOREIGN KEY (`id_ot`) REFERENCES `orden_trabajo` (`idorden_trabajo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_producto` FOREIGN KEY (`id_producto`) REFERENCES `tipo_producto` (`idtipo_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION
);


CREATE TABLE `presupuesto_repuesto` (
  `idpresupuesto_repuesto` int(11) NOT NULL AUTO_INCREMENT,
  `id_presupuesto` int(11) NOT NULL,
  `id_repuesto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`idpresupuesto_repuesto`),
  KEY `id_presupuesto_idx` (`id_presupuesto`),
  KEY `id_repuesto_idx` (`id_repuesto`),
  CONSTRAINT `id_presupuesto` FOREIGN KEY (`id_presupuesto`) REFERENCES `presupuesto` (`idpresupuesto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_repuesto` FOREIGN KEY (`id_repuesto`) REFERENCES `repuesto` (`idrepuesto`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO `20161_Service_G4`.`marca` (`idmarca`, `nombre`) VALUES ('1', 'Samsung');
INSERT INTO `20161_Service_G4`.`marca` (`idmarca`, `nombre`) VALUES ('2', 'Sony');
INSERT INTO `20161_Service_G4`.`marca` (`idmarca`, `nombre`) VALUES ('3', 'Noblex');
INSERT INTO `20161_Service_G4`.`marca` (`idmarca`, `nombre`) VALUES ('4', 'Gafa');
INSERT INTO `20161_Service_G4`.`marca` (`idmarca`, `nombre`) VALUES ('5', 'LG');
INSERT INTO `20161_Service_G4`.`marca` (`idmarca`, `nombre`) VALUES ('6', 'Asus');
INSERT INTO `20161_Service_G4`.`marca` (`idmarca`, `nombre`) VALUES ('7', 'GForce');
INSERT INTO `20161_Service_G4`.`marca` (`idmarca`, `nombre`) VALUES ('8', 'ATIRadeon');


INSERT INTO `20161_Service_G4`.`tipo_producto` (`idtipo_producto`, `id_marca`, `nombre`) VALUES ('1', '2', 'Sistema de Sonido');
INSERT INTO `20161_Service_G4`.`tipo_producto` (`idtipo_producto`, `id_marca`, `nombre`) VALUES ('2', '1', 'TV LCD');
INSERT INTO `20161_Service_G4`.`tipo_producto` (`idtipo_producto`, `id_marca`, `nombre`) VALUES ('3', '4', 'Heladera');
INSERT INTO `20161_Service_G4`.`tipo_producto` (`idtipo_producto`, `id_marca`, `nombre`) VALUES ('4', '3', 'Notebook');

INSERT INTO `20161_Service_G4`.`cliente` (`id_cliente`, `nombre`, `apellido`, `dni`, `telefono`, `mail`, `direccion`, `altura`, `piso`, `dpto`, `localidad`) VALUES ('1', 'Lucas', 'Espinosa', '28659324', '46635548', 'lme@gmail.com', 'Esteban de Luca', '3865', '1', 'A', 'Los Polvorines');
INSERT INTO `20161_Service_G4`.`cliente` (`id_cliente`, `nombre`, `apellido`, `dni`, `telefono`, `mail`, `direccion`, `altura`, `piso`, `dpto`, `localidad`) VALUES ('2', 'Bruno', 'Bidone', '35444567', '46646512', 'bb@gmail.com', 'Paunero ', '2856', '3', 'A', 'San Miguel');
INSERT INTO `20161_Service_G4`.`cliente` (`id_cliente`, `nombre`, `apellido`, `dni`, `telefono`, `mail`, `direccion`, `altura`, `piso`, `dpto`, `localidad`) VALUES ('3', 'Daniel','Romero', '44672500', '1156329800', 'dr@live.com', 'Mitre ', '9970', '4', 'C', 'San Miguel');
INSERT INTO `20161_Service_G4`.`cliente` (`id_cliente`, `nombre`, `apellido`, `dni`, `telefono`, `mail`, `direccion`, `altura`, `piso`, `dpto`, `localidad`) VALUES ('4', 'Braian','Marquez Chesko', '37288643', '1109784201', 'bmc@outlook.com', 'Sucre', '3540', '1', 'B', 'Villa de Mayo');

INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('1', 'Pendiente de presupuesto');
INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('2', 'Pendiente de aprobación');
INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('3', 'Aprobada');
INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('4', 'En Reparación');
INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('5', 'Cancelada');
INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('6', 'Suspendida');
INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('7', 'Realizada');
INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('8', 'Entregada');
INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('9', 'Finalizada');
INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('10', 'Aprobado por el cliente');
INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('11', 'Rechazado por el cliente');
INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('12', 'Rechazado por el técnico');
INSERT INTO `20161_Service_G4`.`estado` (`idestado`, `nombre`) VALUES ('13', 'Vencido');

INSERT INTO `20161_Service_G4`.`repuesto` (`idrepuesto`, `nombre`, `descripcion`, `id_marca_repuesto`, `costo`, `precio`, `stock`) VALUES ('1', 'ST29J', 'Sonda Temperatura', '4', '79.20', '110', '10');
INSERT INTO `20161_Service_G4`.`repuesto` (`idrepuesto`, `nombre`, `descripcion`, `id_marca_repuesto`, `costo`, `precio`, `stock`) VALUES ('2', 'TR01', 'Termostato', '4', '105', '142', '10');
INSERT INTO `20161_Service_G4`.`repuesto` (`idrepuesto`, `nombre`, `descripcion`, `id_marca_repuesto`, `costo`, `precio`, `stock`) VALUES ('3', 'DP505', 'Flex Display Pantalla', '3', '190', '256.50', '5');
INSERT INTO `20161_Service_G4`.`repuesto` (`idrepuesto`, `nombre`, `descripcion`, `id_marca_repuesto`, `costo`, `precio`, `stock`) VALUES ('4', 'HDWDBlue', 'Disco Rigido WD 500MB', '3', '800', '1080', '4');
INSERT INTO `20161_Service_G4`.`repuesto` (`idrepuesto`, `nombre`, `descripcion`, `id_marca_repuesto`, `costo`, `precio`, `stock`) VALUES ('5', 'CI090', 'Circuito Integrado', '1', '700', '910', '6');
INSERT INTO `20161_Service_G4`.`repuesto` (`idrepuesto`, `nombre`, `descripcion`, `id_marca_repuesto`, `costo`, `precio`, `stock`) VALUES ('6', 'PIA002', 'Placa Alimentacion Invertida', '1', '1200', '1620', '7');
INSERT INTO `20161_Service_G4`.`repuesto` (`idrepuesto`, `nombre`, `descripcion`, `id_marca_repuesto`, `costo`, `precio`, `stock`) VALUES ('7', 'LZ2020', 'Lazer Lector CD', '2', '500', '675', '7');
INSERT INTO `20161_Service_G4`.`repuesto` (`idrepuesto`, `nombre`, `descripcion`, `id_marca_repuesto`, `costo`, `precio`, `stock`) VALUES ('8', 'VL45', 'Volumetro Led', '2', '780', '1053', '7');
INSERT INTO `20161_Service_G4`.`repuesto` (`idrepuesto`, `nombre`, `descripcion`, `id_marca_repuesto`, `costo`, `precio`, `stock`) VALUES ('9', 'PT46', 'Potenciometro', '2', '418', '564.30', '3');
INSERT INTO `20161_Service_G4`.`repuesto` (`idrepuesto`, `nombre`, `descripcion`, `id_marca_repuesto`, `costo`, `precio`, `stock`) VALUES ('10', 'ASUS7745RI', 'Mother Board', '6', '1800', '2430', '0');
INSERT INTO `20161_Service_G4`.`repuesto` (`idrepuesto`, `nombre`, `descripcion`, `id_marca_repuesto`, `costo`, `precio`, `stock`) VALUES ('11', 'GFroce S9', 'Placa de Video Serie 9', '7', '2500', '3375', '0');
INSERT INTO `20161_Service_G4`.`repuesto` (`idrepuesto`, `nombre`, `descripcion`, `id_marca_repuesto`, `costo`, `precio`, `stock`) VALUES ('12', 'ATIRadeon S8', 'Placa de Video Serie 8', '8', '2200', '2970', '0');



