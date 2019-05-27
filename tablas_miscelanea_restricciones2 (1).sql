
drop schema miscelanea cascade;
create schema miscelanea authorization postgres;

set search_path to miscelanea;

create table cliente
(
	id_c 		int primary key,
	nombre 		varchar (60),
	ap_p     	varchar (13),
	ap_m     	varchar (13),
	telefono	varchar (15),
	domicilio       varchar (100),
	fecha_registro  date check(fecha_registro < current_date),
	fecha_inicio    date,
	fecha_limite    date,
	mon_pagado      numeric (10,2),
	mon_a_pagar     numeric (10,2),
	mon_limite      numeric (10,2) check(mon_limite >= 1 and mon_limite <= 500),
	edad            int check(edad >=18)
);

create table proveedor
(
	id_p		int primary key,
	nombre          varchar (40),
	RFC     	varchar (40),
	telefono	varchar (15),
	e_mail		varchar (60),
	domicilio       varchar (100)
	
);

create table producto
(
	codigo		int primary key,
	nombre          varchar (50),
	descripcion	varchar (80),
	precio_c	numeric (7,3),
	precio_v	numeric (5,3),
	presentacion    varchar (50),
	marca           varchar (50),
	tipo            varchar (50),
	id_p             int,
	foreign key (id_p) references proveedor (id_p)
);


create table empleado
(
	id_e		int primary key,
	nombre		varchar (60),
	ap_p            varchar (50),
	ap_m            varchar (50),
	fecha_ingreso	date,
	fecha_nacimiento date check(fecha_nacimiento < current_date),
	domicilio       varchar (50),
	edad            int check(edad >=18)
);

create table compra
(
	folio_c	int primary key,
	fecha		date,
	id_e		int,
	monto           numeric (10,2),
	foreign key (id_e) references empleado (id_e)
);

create table det_compra
(
	folio_c		int,
	codigo		int,
	cantidad	int,
	descuentos      numeric (10,2),
	observaciones   varchar (50),
	id_p            int,
	foreign key (folio_c) references compra (folio_c),
	foreign key (codigo) references producto (codigo),
	foreign key (id_p) references proveedor (id_p),
);

create table venta
(
	folio_v		int primary key,
	fecha		date,
	id_c		int,
	id_e		int,
	monto           numeric (10,2),
	foreign key (id_c) references cliente (id_c),
	foreign key (id_e) references empleado (id_e)
);

create table detalle_venta
(
	folio_v		int,
	codigo		int,
	cantidad	int,
	descuentos      numeric (10,2),
	observaciones   varchar (50),
	foreign key (folio_v) references venta (folio_v),
	foreign key (codigo) references producto (codigo)
);


create table mostrador
(
     id_e        int,
     id_mostrador     int,
     foreign key (id_e) references empleado (id_e)
);
create table administrativo
(
     id_e       int,
     id_administrativo     int,
     foreign key (id_e) references empleado (id_e)
);

create table usuario 
(
id_u       int primary key,
tipo       varchar (50),
contraseña varchar (15),
id_e       int,
foreign key (id_e) references empleado (id_e)
);


