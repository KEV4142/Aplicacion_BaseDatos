CREATE DATABASE Viajes;
USE Viajes;
-- DROP DATABASE Viajes;
-- Tablas
CREATE TABLE Sucursales(
    SucursalID INT IDENTITY(1,1) NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    Direccion   VARCHAR(100) NOT NULL,
    Coordenada VARCHAR(50) NOT NULL,
    Estado      VARCHAR(1) NOT NULL DEFAULT 'A'
);
CREATE TABLE Colaboradores (
	ColaboradorID	INT IDENTITY(1,1) NOT NULL,
    Nombre			varchar(100) NOT NULL,
    Direccion		varchar(100) NOT NULL,
    Coordenada		varchar(50) NOT NULL,
    Estado			varchar(1) NOT NULL DEFAULT 'A'
);
CREATE TABLE SucursalesColaboradores (
    SucursalID	INT NOT NULL,
    ColaboradorID	INT NOT NULL,
    Distancia		INT NOT NULL,
    Estado		varchar(1) NOT NULL DEFAULT 'A'
);
CREATE TABLE Transportistas (
	TransportistaID	INT IDENTITY(1,1) NOT NULL,
    Descripcion		varchar(100) NOT NULL,
    Tarifa			decimal(5,2) NOT NULL DEFAULT '0.00',
    Estado			varchar(1) NOT NULL DEFAULT 'A'
);
-- DROP TABLE Sucursal;
CREATE TABLE Viajes (
	ViajeID	INT IDENTITY(1,1) NOT NULL,
    Fecha		datetime NOT NULL,
    SucursalID	INT NOT NULL,
    UsuarioID NVARCHAR(450) NOT NULL,
    TransportistaID	INT NOT NULL,
    Estado		varchar(1) NOT NULL DEFAULT 'A'
);
CREATE TABLE ViajesDetalle (
	ViaDetID	INT IDENTITY(1,1) NOT NULL,
    ViajeID	INT NOT NULL,
    ColaboradorID	INT NOT NULL,
    UsuarioID NVARCHAR(450) NOT NULL
);

-- constraints
-- Llave Primaria
ALTER TABLE Sucursales ADD CONSTRAINT pkSucursalID PRIMARY KEY(SucursalID);
ALTER TABLE Colaboradores ADD CONSTRAINT pkColaboradorID PRIMARY KEY(ColaboradorID);
ALTER TABLE SucursalesColaboradores ADD CONSTRAINT pkSucursalColaboradorID PRIMARY KEY(SucursalID,ColaboradorID);
ALTER TABLE Transportistas ADD CONSTRAINT pkTransportistaID PRIMARY KEY(TransportistaID);
ALTER TABLE Viajes ADD CONSTRAINT pkViajeID PRIMARY KEY(ViajeID);
ALTER TABLE ViajesDetalle ADD CONSTRAINT pkViaDetID PRIMARY KEY(ViaDetID);

-- Llaves Foranea
ALTER TABLE SucursalesColaboradores ADD CONSTRAINT fkSucursalesColaboradoresSucursalID FOREIGN KEY(SucursalID) REFERENCES Sucursales(SucursalID);
ALTER TABLE SucursalesColaboradores ADD CONSTRAINT fkSucursalesColaboradoresColaboradorID FOREIGN KEY(ColaboradorID) REFERENCES Colaboradores(ColaboradorID);
ALTER TABLE Viajes ADD CONSTRAINT fkViajesSucursalID FOREIGN KEY(SucursalID) REFERENCES Sucursales(SucursalID);
ALTER TABLE Viajes ADD CONSTRAINT fkViajesTransportistaID FOREIGN KEY(TransportistaID) REFERENCES Transportistas(TransportistaID);
ALTER TABLE ViajesDetalle ADD CONSTRAINT fkViajesDetalleViajeID FOREIGN KEY(ViajeID) REFERENCES Viajes(ViajeID);
ALTER TABLE ViajesDetalle ADD CONSTRAINT fkViajesDetalleColaboradorID FOREIGN KEY(ColaboradorID) REFERENCES Colaboradores(ColaboradorID);

-- Check
ALTER TABLE Sucursales ADD CONSTRAINT ckSucursalesEstado CHECK (Estado IN('A','I','B'));
ALTER TABLE Colaboradores ADD CONSTRAINT ckColaboradoresEstado CHECK (Estado IN('A','I','B'));
ALTER TABLE SucursalesColaboradores ADD CONSTRAINT ckSucursalesColaboradoresEstado CHECK (Estado IN('A','I','B'));
ALTER TABLE SucursalesColaboradores ADD CONSTRAINT ckSucursalesColaboradoresDistancia CHECK (Distancia > 0 AND Distancia <= 50);
ALTER TABLE Transportistas ADD CONSTRAINT ckTransportistasEstado CHECK (Estado IN('A','I','B'));
ALTER TABLE Transportistas ADD CONSTRAINT ckSTransportistasTarifa CHECK (Tarifa > 0);
ALTER TABLE Viajes ADD CONSTRAINT ckViajesEstado CHECK (Estado IN('A','I','B'));

-- Cambios
-- ALTER TABLE Viajes ALTER COLUMN UsuarioID NVARCHAR(450) NOT NULL;
-- ALTER TABLE ViajesDetalle ALTER COLUMN UsuarioID NVARCHAR(450) NOT NULL;

ALTER TABLE Viajes ADD CONSTRAINT fkViajesUsuarioID FOREIGN KEY(UsuarioID) REFERENCES AspNetUsers(Id);
ALTER TABLE ViajesDetalle ADD CONSTRAINT fkViajesDetalleUsuarioID FOREIGN KEY(UsuarioID) REFERENCES AspNetUsers(Id);
