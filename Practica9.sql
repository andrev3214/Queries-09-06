use master;
go

if exists (select * from sys.databases where name = 'EmpresaSQL')
begin
    drop database EmpresaSQL;
end
go

create database EmpresaSQL;
go


use EmpresaSQL
go

create table TDepartamento(
	NDepartamentoID int primary key identity(1,1),
	cNombreDepartamento varchar(100) unique not null,
)
go

create table TCargo
(
    nCargoID int identity(1,1) primary key,
    cNombreCargo varchar(100) NOT NULL unique
)
go

create table TEmpleado
(
    nEmpleadoID int identity(1,1) primary key,

    cNIF varchar(20) unique,

    cNombre varchar(100) NOT NULL,

    cApellido varchar(100) NOT NULL,

    nDepartamentoID int NOT NULL,

    nCargoID int NOT NULL,

    dFechaContratacion date
        constraint DF_TEmpleado_FechaContratacion
        default getdate(),

    nSalario decimal(10,2)
        constraint CHK_TEmpleado_Salario
        check (nSalario > 300),

    constraint FK_TEmpleado_Departamento
        foreign key (nDepartamentoID)
        references TDepartamento(nDepartamentoID),

    constraint FK_TEmpleado_Cargo
        foreign key (nCargoID)
        references TCargo(nCargoID)
)
go

alter table TEmpleado
add constraint FK_TEmpleado_TDepartamento
foreign key (nDepartamentoID)
references TDepartamento(nDepartamentoID);
go

alter table TEmpleado
add constraint FK_TEmpleado_TCargo
foreign key (nCargoID)
references TCargo(nCargoID);
go

create table TProyecto
(
    nProyectoID int identity(1,1) primary key,
    
    cNombreProyecto varchar(150) not null,
    
    dFechaInicio date not null,
    
    dFechaFinalizacion date NULL
)
go

create table TEmpleadoProyecto
(
    nEmpleadoID int NOT NULL,
    nProyectoID int NOT NULL,

    constraint PK_TEmpleadoProyecto
    primary key (nEmpleadoID, nProyectoID),

    constraint FK_TEmpleadoProyecto_Empleado
    foreign key (nEmpleadoID)
    references TEmpleado(nEmpleadoID),

    constraint FK_TEmpleadoProyecto_Proyecto
    foreign key (nProyectoID)
    references TProyecto(nProyectoID)
)
go

alter table TEmpleado
add cEmail varchar(150);
go


alter table TEmpleado
add cTelefono varchar(15);
go


alter table TEmpleado
alter column cNombre varchar(100) not null;
go


alter table TEmpleado
alter column cApellido varchar(100) not null;
go


alter table TEmpleado
add cDireccion varchar(200);
go


alter table TEmpleado
add nEdad int;
go


alter table TEmpleado
add constraint CHK_TEmpleado_Edad
check (nEdad between 18 and 65);
go


alter table TEmpleado
add constraint UQ_TEmpleado_Email
unique (cEmail);
go


alter table TEmpleado
add bActivo bit
constraint DF_TEmpleado_Activo
default 1;
go


alter table TEmpleado
drop column cDireccion;
go


alter table TEmpleado
alter column cTelefono varchar(20);
go


alter table TEmpleado
add cGenero char(1);
go


alter table TEmpleado
add constraint CHK_TEmpleado_Genero
check (cGenero in ('M','F'));
go


alter table TEmpleado
add dFechaNacimiento date;
go


create table TSucursal
(
    nSucursalID int identity(1,1) primary key,

    cNombreSucursal varchar(100) not null,

    cDireccion varchar(200),

    cTelefono varchar(20)
)
go

insert into TDepartamento (cNombreDepartamento)
values
('Recursos Humanos'),
('Finanzas'),
('Tecnologia'),
('Ventas'),
('Marketing');
go


insert into TCargo (cNombreCargo)
values
('Gerente'),
('Analista'),
('Programador'),
('Supervisor'),
('Asistente');
go

insert into TEmpleado
(
    cNIF,
    cNombre,
    cApellido,
    nDepartamentoID,
    nCargoID,
    dFechaContratacion,
    nSalario,
    cEmail,
    cTelefono,
    nEdad,
    bActivo,
    cGenero,
    dFechaNacimiento
)
values
('EMP001','Juan','Perez',1,1,'2024-01-10',1200,'juan@empresa.com','88881111',35,1,'M','1990-05-10'),
('EMP002','Maria','Lopez',2,2,'2024-02-15',950,'maria@empresa.com','88882222',28,1,'F','1997-08-12'),
('EMP003','Carlos','Gomez',3,3,'2024-03-20',1500,'carlos@empresa.com','88883333',30,1,'M','1995-03-15'),
('EMP004','Ana','Martinez',4,4,'2024-04-05',850,'ana@empresa.com','88884444',25,1,'F','2000-01-20'),
('EMP005','Luis','Ramirez',5,5,'2024-05-10',700,'luis@empresa.com','88885555',24,1,'M','2001-06-11'),
('EMP006','Sofia','Torres',1,2,'2024-06-18',1100,'sofia@empresa.com','88886666',32,1,'F','1993-04-08'),
('EMP007','Pedro','Castillo',2,3,'2024-07-22',1400,'pedro@empresa.com','88887777',40,1,'M','1985-09-25'),
('EMP008','Laura','Vega',3,4,'2024-08-14',980,'laura@empresa.com','88888888',29,1,'F','1996-11-30'),
('EMP009','Miguel','Diaz',4,5,'2024-09-09',750,'miguel@empresa.com','88889999',27,1,'M','1998-02-18'),
('EMP010','Elena','Ruiz',5,1,'2024-10-01',1700,'elena@empresa.com','88880000',38,1,'F','1987-12-05');
go

insert into TProyecto
(
    cNombreProyecto,
    dFechaInicio,
    dFechaFinalizacion
)
values
('Sistema ERP','2025-01-01','2025-12-31'),
('Portal Web','2025-02-01','2025-08-31'),
('App Movil','2025-03-01','2025-10-31');
go

insert into TEmpleadoProyecto
(
    nEmpleadoID,
    nProyectoID
)
values
(1,1),
(2,1),
(3,1),
(4,2),
(5,2),
(6,2),
(7,3),
(8,3),
(9,3),
(10,1);
go


insert into TEmpleado
(
    cNIF,
    cNombre,
    cApellido,
    nDepartamentoID,
    nCargoID,
    nSalario,
    cEmail,
    cTelefono,
    nEdad,
    cGenero,
    dFechaNacimiento
)
values
(
    'EMP011',
    'Roberto',
    'Mendoza',
    3,
    3,
    1300,
    'roberto@empresa.com',
    '88991122',
    31,
    'M',
    '1994-07-15'
);
go

insert into TEmpleado
(
    cNIF,
    cNombre,
    cApellido,
    nDepartamentoID,
    nCargoID,
    nSalario,
    cEmail,
    cTelefono,
    nEdad,
    cGenero,
    dFechaNacimiento
)
values
(
    'EMP012',
    'Patricia',
    'Herrera',
    2,
    2,
    1150,
    'patricia@empresa.com',
    '88776655',
    34,
    'F',
    '1991-09-21'
);
go

insert into TEmpleado
(
    cNIF,
    cNombre,
    cApellido,
    nDepartamentoID,
    nCargoID,
    nSalario,
    cEmail,
    cTelefono,
    nEdad,
    cGenero,
    dFechaNacimiento
)
values
(
    'EMP013',
    'Fernando',
    'Morales',
    4,
    4,
    1000,
    'fernando@empresa.com',
    '88665544',
    29,
    'M',
    '1996-05-18'
);
go


insert into TCargo (cNombreCargo)
values
('Contador'),
('Diseñador'),
('Consultor');
go

insert into TEmpleado
(
    cNIF,
    cNombre,
    cApellido,
    nDepartamentoID,
    nCargoID,
    nSalario
)
values
(
    'EMP014',
    'Prueba',
    'Error',
    1,
    1,
    -500
);
go


update TEmpleado
set nSalario = nSalario * 1.10;
go

update TEmpleado
set nSalario = nSalario * 1.20
where nDepartamentoID = 3;
go

update TEmpleado
set cEmail = 'juan.perez@empresa.com'
where nEmpleadoID = 1;
go

update TEmpleado
set nCargoID = 2
where nEmpleadoID = 3;
go

update TEmpleado
set nDepartamentoID = 5
where nEmpleadoID in (2,4);
go

update TEmpleado
set bActivo = 0
where nSalario < 500;
go

update TProyecto
set dFechaFinalizacion = '2026-12-31'
where nProyectoID = 1;
go

insert into TEmpleadoProyecto
(
    nEmpleadoID,
    nProyectoID
)
values
(
    1,
    2
);
go

delete from TEmpleado
where cNIF = 'EMP013';
go

delete from TEmpleado
where bActivo = 0;
go

delete from TEmpleadoProyecto
where nProyectoID = 3;
go

delete from TProyecto
where nProyectoID = 3;
go

delete from TEmpleadoProyecto
where nEmpleadoID = 5;
go

delete from TDepartamento
where nDepartamentoID = 6
and not exists
(
    select 1
    from TEmpleado
    where TEmpleado.nDepartamentoID = TDepartamento.nDepartamentoID
);
go

select
    e.cNombre,
    e.cApellido,
    p.cNombreProyecto
from TEmpleado e
inner join TEmpleadoProyecto ep
    on e.nEmpleadoID = ep.nEmpleadoID
inner join TProyecto p
    on ep.nProyectoID = p.nProyectoID;
go


select
    d.cNombreDepartamento,
    count(e.nEmpleadoID) as CantidadEmpleados
from TDepartamento d
left join TEmpleado e
    on d.nDepartamentoID = e.nDepartamentoID
group by d.cNombreDepartamento;
go

select
    d.cNombreDepartamento,
    avg(e.nSalario) as SalarioPromedio
from TDepartamento d
inner join TEmpleado e
    on d.nDepartamentoID = e.nDepartamentoID
group by d.cNombreDepartamento;
go

select
    d.cNombreDepartamento,
    max(e.nSalario) as SalarioMaximo,
    min(e.nSalario) as SalarioMinimo
from TDepartamento d
inner join TEmpleado e
    on d.nDepartamentoID = e.nDepartamentoID
group by d.cNombreDepartamento;
go

select
    p.cNombreProyecto,
    count(ep.nEmpleadoID) as CantidadEmpleados
from TProyecto p
inner join TEmpleadoProyecto ep
    on p.nProyectoID = ep.nProyectoID
group by p.cNombreProyecto
having count(ep.nEmpleadoID) > 2;
go

select *
from TEmpleado
where cApellido like 'G%';
go

select *
from TEmpleado
order by nSalario desc;
go

select top 3 *
from TEmpleado
order by nSalario desc;
go

select *
from TEmpleado
where nEdad between 25 and 40;
go

select
    count(*) as TotalEmpleadosActivos
from TEmpleado
where bActivo = 1;
go

select
    count(*) as TotalProyectos
from TProyecto;
go

alter table TEmpleado
drop constraint CHK_TEmpleado_Edad;
go

alter table TEmpleado
drop constraint UQ_TEmpleado_Email;
go


alter table TEmpleado
add constraint CHK_TEmpleado_Edad
check (nEdad between 18 and 65);
go

alter table TEmpleado
add constraint UQ_TEmpleado_Email
unique (cEmail);
go

drop table TEmpleadoProyecto;
go


drop table TProyecto;
go


drop table TEmpleado;
go


drop table TCargo;
go

drop table TDepartamento;
go

drop table TSucursal;
go

use master;
go

drop database EmpresaSQL;
go

create table TCliente
(
    nClienteID int identity(1,1) primary key,

    cNIF varchar(20) unique not null,

    cNombre varchar(100) not null,

    cApellido varchar(100) not null,

    cEmail varchar(150) unique,

    cTelefono varchar(20),

    cDireccion varchar(200),

    cGenero char(1)
        constraint CHK_TCliente_Genero
        check (cGenero in ('M','F')),

    dFechaRegistro date
        constraint DF_TCliente_FechaRegistro
        default getdate(),

    bActivo bit
        constraint DF_TCliente_Activo
        default 1
);
go

create table TVenta
(
    nVentaID int identity(1,1) primary key,

    nClienteID int not null,

    dFechaVenta date not null,

    nMonto decimal(10,2)
        constraint CHK_TVenta_Monto
        check (nMonto > 0),

    constraint FK_TVenta_Cliente
        foreign key (nClienteID)
        references TCliente(nClienteID)
);
go

insert into TCliente
(
    cNIF,
    cNombre,
    cApellido,
    cEmail,
    cTelefono,
    cDireccion,
    cGenero
)
values
('CLI001','Juan','Perez','juan@correo.com','88880001','Managua','M'),
('CLI002','Maria','Lopez','maria@correo.com','88880002','Masaya','F'),
('CLI003','Carlos','Gomez','carlos@correo.com','88880003','Leon','M'),
('CLI004','Ana','Martinez','ana@correo.com','88880004','Granada','F'),
('CLI005','Luis','Ramirez','luis@correo.com','88880005','Rivas','M'),
('CLI006','Sofia','Torres','sofia@correo.com','88880006','Chinandega','F'),
('CLI007','Pedro','Castillo','pedro@correo.com','88880007','Esteli','M'),
('CLI008','Laura','Vega','laura@correo.com','88880008','Jinotega','F'),
('CLI009','Miguel','Diaz','miguel@correo.com','88880009','Boaco','M'),
('CLI010','Elena','Ruiz','elena@correo.com','88880010','Matagalpa','F'),
('CLI011','Roberto','Mendoza','roberto@correo.com','88880011','Managua','M'),
('CLI012','Patricia','Herrera','patricia@correo.com','88880012','Masaya','F'),
('CLI013','Fernando','Morales','fernando@correo.com','88880013','Leon','M'),
('CLI014','Daniela','Silva','daniela@correo.com','88880014','Granada','F'),
('CLI015','Jose','Flores','jose@correo.com','88880015','Rivas','M'),
('CLI016','Gabriela','Rojas','gabriela@correo.com','88880016','Esteli','F'),
('CLI017','Ricardo','Mora','ricardo@correo.com','88880017','Boaco','M'),
('CLI018','Valeria','Campos','valeria@correo.com','88880018','Jinotega','F'),
('CLI019','Andres','Ortiz','andres@correo.com','88880019','Matagalpa','M'),
('CLI020','Karen','Navarro','karen@correo.com','88880020','Managua','F');
go

insert into TVenta (nClienteID,dFechaVenta,nMonto)
values
(1,'2026-01-05',150),(2,'2026-01-08',300),(3,'2026-01-12',450),
(4,'2026-01-15',600),(5,'2026-01-20',250),(6,'2026-02-03',180),
(7,'2026-02-06',520),(8,'2026-02-10',430),(9,'2026-02-15',270),
(10,'2026-02-20',350),(11,'2026-03-01',800),(12,'2026-03-04',120),
(13,'2026-03-07',700),(14,'2026-03-10',260),(15,'2026-03-15',410),
(16,'2026-03-18',390),(17,'2026-03-22',560),(18,'2026-03-25',670),
(19,'2026-03-28',740),(20,'2026-03-30',210),(1,'2026-04-01',150),
(2,'2026-04-02',250),(3,'2026-04-03',350),(4,'2026-04-04',450),
(5,'2026-04-05',550),(6,'2026-04-06',650),(7,'2026-04-07',750),
(8,'2026-04-08',850),(9,'2026-04-09',950),(10,'2026-04-10',1050),
(11,'2026-05-01',200),(12,'2026-05-02',300),(13,'2026-05-03',400),
(14,'2026-05-04',500),(15,'2026-05-05',600),(16,'2026-05-06',700),
(17,'2026-05-07',800),(18,'2026-05-08',900),(19,'2026-05-09',1000),
(20,'2026-05-10',1100),(1,'2026-06-01',250),(2,'2026-06-02',350),
(3,'2026-06-03',450),(4,'2026-06-04',550),(5,'2026-06-05',650),
(6,'2026-06-06',750),(7,'2026-06-07',850),(8,'2026-06-08',950),
(9,'2026-06-09',1050),(10,'2026-06-10',1150);
go

update TVenta
set nMonto = nMonto * 1.10
where nMonto > 1000;
go

delete from TCliente
where nClienteID not in
(
    select distinct nClienteID
    from TVenta
);
go

select top 5
    c.nClienteID,
    c.cNombre,
    c.cApellido,
    sum(v.nMonto) as TotalCompras
from TCliente c
inner join TVenta v
    on c.nClienteID = v.nClienteID
group by
    c.nClienteID,
    c.cNombre,
    c.cApellido
order by TotalCompras desc;
go

select
    month(dFechaVenta) as Mes,
    sum(nMonto) as TotalVentas
from TVenta
group by month(dFechaVenta)
order by Mes;
go

select
    c.nClienteID,
    c.cNombre,
    c.cApellido,
    avg(v.nMonto) as PromedioVentas
from TCliente c
inner join TVenta v
    on c.nClienteID = v.nClienteID
group by
    c.nClienteID,
    c.cNombre,
    c.cApellido;
go

select
    c.nClienteID,
    c.cNombre,
    c.cApellido,
    v.nVentaID,
    v.dFechaVenta,
    v.nMonto,
    r.CantidadVentas
from TCliente c
inner join TVenta v
    on c.nClienteID = v.nClienteID
inner join
(
    select
        nClienteID,
        count(*) as CantidadVentas
    from TVenta
    group by nClienteID
) r
    on c.nClienteID = r.nClienteID;
go
