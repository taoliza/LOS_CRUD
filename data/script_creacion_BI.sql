USE [GD1C2023]
GO

------------- LIMPIAR FUNCIONES----------------------

IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'BI_CALCULAR_RANGO_ETARIO')
    DROP FUNCTION LOS_CRUD.BI_CALCULAR_RANGO_ETARIO;

IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'BI_CALCULAR_UBICACION')
    DROP FUNCTION LOS_CRUD.BI_CALCULAR_UBICACION;

IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'BI_CALCULAR_RANGO_TURNOS')
    DROP FUNCTION LOS_CRUD.BI_CALCULAR_RANGO_TURNOS;

IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'BI_CALCULAR_DIA_SEMANA')
    DROP FUNCTION LOS_CRUD.BI_CALCULAR_DIA_SEMANA;
GO

------------- LIMPIAR TABLAS ------------------------

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_TIEMPO')
    DROP TABLE LOS_CRUD.BI_TIEMPO;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_DIAS')
    DROP TABLE LOS_CRUD.BI_DIAS;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_UBICACION')
    DROP TABLE LOS_CRUD.BI_UBICACION;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_RANGO_TURNOS')
    DROP TABLE LOS_CRUD.BI_RANGO_TURNOS;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_SUCURSAL')
    DROP TABLE LOS_CRUD.BI_SUCURSAL;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_RANGO_ETARIO')
    DROP TABLE LOS_CRUD.BI_RANGO_ETARIO;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_MDP')
    DROP TABLE LOS_CRUD.BI_MDP;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_CATEGORIA_PRODUCTO')
    DROP TABLE LOS_CRUD.BI_CATEGORIA_PRODUCTO;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_SUBCATEGORIA_PRODUCTO')
    DROP TABLE LOS_CRUD.BI_SUBCATEGORIA_PRODUCTO;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_Tickets')
    DROP TABLE LOS_CRUD.BI_Tickets;
GO

------------------ LIMPIAR PROCEDURES ---------------------------

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_UBICACION')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_UBICACION;

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_RANGO_ETARIO')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_RANGO_ETARIO;

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_DIAS')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_DIAS;

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_TIEMPO')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_TIEMPO;

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_RANGO_TURNOS')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_RANGO_TURNOS;

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_SUCURSAL')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_SUCURSAL;

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_TICKETS')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_TICKETS;
GO


---------------------- LIMPIAR VISTAS ----------------------

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_TicketPromedioMensual')
    DROP VIEW LOS_CRUD.BI_TicketPromedioMensual;
GO

---------------- FUNCIONES ----------------

--Rango Etario
CREATE FUNCTION LOS_CRUD.BI_CALCULAR_RANGO_ETARIO(@FECHA_NAC DATETIME2(3))
	RETURNS INT
BEGIN
	DECLARE @EDAD INT
	DECLARE @COD_RANGO_ETARIO INT

	SET @EDAD = YEAR(GETDATE()) - YEAR(@FECHA_NAC)

	IF @EDAD < 25
		SET @COD_RANGO_ETARIO = 1
    
	IF @EDAD BETWEEN 25 AND 35 
		SET @COD_RANGO_ETARIO = 2

	IF @EDAD BETWEEN 35 AND 50
		SET @COD_RANGO_ETARIO = 3

	IF @EDAD > 50
		SET @COD_RANGO_ETARIO = 4

	RETURN @COD_RANGO_ETARIO
	
END
GO

-- Calcular Ubicacion
CREATE FUNCTION LOS_CRUD.BI_CALCULAR_UBICACION(@cod_localidad INT)
	RETURNS NVARCHAR(100)
BEGIN
	DECLARE @PROVINCIA NVARCHAR(100)
    DECLARE @LOCALIDAD NVARCHAR(100)
	DECLARE @UBICACION NVARCHAR(100)

	SET @PROVINCIA = 
                    SELECT TOP 1 p.nombre_provincia
                    FROM LOS_CRUD.Localidad l
                    JOIN LOS_CRUD.Provincia p ON p.cod_provincia = l.cod_provincia
                    WHERE l.cod_localidad = @cod_localidad
    SET @LOCALIDAD = 
                    SELECT TOP 1 l.nombre_localidad
                    FROM LOS_CRUD.Localidad l
                    WHERE l.cod_localidad = @cod_localidad
    
    SET @UBICACION = @LOCALIDAD + ', ' + @PROVINCIA

END
GO

--Rango turnos
CREATE FUNCTION LOS_CRUD.BI_CALCULAR_RANGO_TURNOS(@FECHA_HORA DATETIME2(3))
RETURNS INT
AS
BEGIN
    DECLARE @HORA TIME
    DECLARE @COD_RANGO_TURNOS INT

    SET @HORA = CONVERT(TIME, @FECHA_HORA)

    IF @hora >= '08:00' AND @hora < '12:00'
        SET @COD_RANGO_TURNOS = 1
    ELSE IF @hora >= '12:00' AND @hora < '16:00'
        SET @COD_RANGO_TURNOS = 2
    ELSE IF @hora >= '16:00' AND @hora < '20:00'
        SET @COD_RANGO_TURNOS = 3
    RETURN @COD_RANGO_TURNOS
END
GO

--Dia
CREATE FUNCTION LOS_CRUD.BI_CALCULAR_DIA_SEMANA(@FECHA_HORA DATETIME2(3))
RETURNS NVARCHAR(50) 
AS
BEGIN 
	DECLARE @DiaSemana NVARCHAR(30);
	SET @DiaSemana = CASE DATEPART(WEEKDAY, @FECHA_HORA)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Lunes'
			WHEN 3 THEN 'Martes'
			WHEN 4 THEN 'Miércoles'
			WHEN 5 THEN 'Jueves'
			WHEN 6 THEN 'Viernes'
			WHEN 7 THEN 'Sábado'
		END;
	RETURN @DiaSemana;
END;
GO




---------------- MIGRACIONES A DIMENSIONES ----------------

--Ubicacion
CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_UBICACION
AS
BEGIN
INSERT INTO LOS_CRUD.BI_UBICACION(cod_ubicacion,desc_ubicacion)
    SELECT DISTINCT l.cod_localidad, LOS_CRUD.BI_CALCULAR_UBICACION(l.cod_localidad)
    FROM LOS_CRUD.Localidad l
END
GO


--Rango Etario
CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_RANGO_ETARIO
AS
BEGIN 
INSERT INTO LOS_CRUD.BI_RANGO_ETARIO(cod_rango_etario,desc_rango_etario)
	VALUES(1,'<25')
INSERT INTO LOS_CRUD.BI_RANGO_ETARIO(cod_rango_etario,desc_rango_etario)
	VALUES(2,'25-35')
INSERT INTO LOS_CRUD.BI_RANGO_ETARIO(cod_rango_etario,desc_rango_etario)
	VALUES(3,'35-50')
INSERT INTO LOS_CRUD.BI_RANGO_ETARIO(cod_rango_etario,desc_rango_etario)
	VALUES(4,'>50')
END
GO

--Dias
CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_DIAS
AS
BEGIN 
INSERT INTO LOS_CRUD.BI_DIAS(cod_dia,desc_dia)
	VALUES(1,'Domingo')
INSERT INTO LOS_CRUD.BI_DIAS(cod_dia,desc_dia)
	VALUES(2,'Lunes')
INSERT INTO LOS_CRUD.BI_DIAS(cod_dia,desc_dia)
	VALUES(3,'Martes')
INSERT INTO LOS_CRUD.BI_DIAS(cod_dia,desc_dia)
	VALUES(4,'Miércoles')
INSERT INTO LOS_CRUD.BI_DIAS(cod_dia,desc_dia)
	VALUES(5,'Jueves')
INSERT INTO LOS_CRUD.BI_DIAS(cod_dia,desc_dia)
	VALUES(6,'Viernes')
INSERT INTO LOS_CRUD.BI_DIAS(cod_dia,desc_dia)
	VALUES(7,'Sábado')
END
GO

--Tiempo 
CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_TIEMPO
 AS
  BEGIN
    INSERT INTO LOS_CRUD.BI_TIEMPO (tiempo_anio,tiempo_cuatrimestre,tiempo_mes)
		SELECT DISTINCT YEAR(fecha_ticket),DATEPART(QUARTER, t.fecha_hora_ticket), MONTH(fecha_ticket)
		FROM LOS_CRUD.TICKET
  END
GO

--Rango turnos
CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_RANGO_TURNOS
AS
BEGIN 
INSERT INTO LOS_CRUD.BI_RANGO_TURNOS(cod_rango_turnos,desc_rango_turnos)
	VALUES(1,'08:00 - 12:00')
INSERT INTO LOS_CRUD.BI_RANGO_TURNOS(cod_rango_turnos,desc_rango_turnos)
	VALUES(2,'12:00 - 16:00')
INSERT INTO LOS_CRUD.BI_RANGO_TURNOS(cod_rango_turnos,desc_rango_turnos)
	VALUES(3,'16:00 - 20:00')
END
GO

-- Sucursal
CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_SUCURSAL
 AS
  BEGIN
    INSERT INTO LOS_CRUD.BI_SUCURSAL (cod_sucursal, nombre_sucursal, desc_ubicacion)
		SELECT DISTINCT 
		FROM 
  END
GO



---------------- MIGRACIONES A TABLAS EXTRAS ----------------

---------------- MIGRACIONES A HECHOS ----------------
CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_TICKETS
 AS
  BEGIN
    INSERT INTO LOS_CRUD.BI_Ticket (cod_rango_etario_cliente, 
	                                cod_rango_etario_empleado, 
                                    cod_dia_ticket,
                                    cod_tiempo,
                                    total_ticket)
		SELECT 
		
		  END
GO


---------------- TABLAS DIMENSIONALES ----------------

CREATE TABLE LOS_CRUD.BI_TIEMPO(
	cod_tiempo INT IDENTITY(1,1) PRIMARY KEY,
	tiempo_anio INT,
    tiempo_cuatrimestre INT,
	tiempo_mes INT
);

-- Día (Se corresponde con los días de la semana: L-M-M-J-V-S-D)
CREATE TABLE LOS_CRUD.BI_DIAS (
    cod_dia INT PRIMARY KEY,
	desc_dia NVARCHAR(50) NOT NULL
);

-- Ubicacion (Provincia/ Localidad)
CREATE TABLE LOS_CRUD.BI_UBICACION (
    cod_ubicacion INT PRIMARY KEY,
    desc_ubicacion NVARCHAR(100)
);

-- Rango turnos (De 8 a 20 cada 4 horas)
CREATE TABLE LOS_CRUD.BI_RANGO_TURNOS(
    cod_rango_turnos INT IDENTITY(1,1) PRIMARY KEY,
    desc_rango_turnos NVARCHAR(50) NOT NULL
);

-- Sucursal
CREATE TABLE LOS_CRUD.BI_SUCURSAL(
    sucursal_id INT PRIMARY KEY,
    nombre NVARCHAR(255),
    desc_ubicacion NVARCHAR(100),
);

-- Rango etario empleados/ clientes
CREATE TABLE LOS_CRUD.BI_RANGO_ETARIO(
    cod_rango_etario INT PRIMARY KEY,
    desc_rango_etario NVARCHAR(50) NOT NULL,
);

-- Medio de pago
CREATE TABLE LOS_CRUD.BI_MDP(
    cod_mdp INT PRIMARY KEY,
    desc_mdp NVARCHAR(50) NOT NULL
);

-- Categoria de productos
CREATE TABLE LOS_CRUD.BI_CATEGORIA_PRODUCTO(
    cod_categoria INT PRIMARY KEY,
    desc_categoria NVARCHAR(50) NOT NULL
);

-- Subcategoria de productos
CREATE TABLE LOS_CRUD.BI_SUBCATEGORIA_PRODUCTO(
    cod_subcategoria INT PRIMARY KEY,
    desc_subcategoria NVARCHAR(50) NOT NULL
);



---------------- TABLAS DE HECHOS ----------------


CREATE TABLE LOS_CRUD.BI_Tickets (
    
    cod_rango_etario_cliente INT, 
	cod_rango_etario_empleado INT FOREIGN KEY REFERENCES LOS_CRUD.BI_RANGO_ETARIO, 
    cod_dia_ticket INT FOREIGN KEY REFERENCES LOS_CRUD.BI_DIAS,
    cod_tiempo INT FOREIGN KEY REFERENCES LOS_CRUD.BI_TIEMPO
    total_ticket DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cod_rango_etario_cliente) REFERENCES LOS_CRUD.BI_RANGO_ETARIO,
    FOREIGN KEY (cod_rango_etario_empleado) REFERENCES LOS_CRUD.BI_RANGO_ETARIO,
    FOREIGN KEY (cod_dia_ticket) REFERENCES LOS_CRUD.BI_DIAS,
    FOREIGN KEY (cod_tiempo) REFERENCES LOS_CRUD.BI_TIEMPO
);










---------------- EXECUTES ----------------

---------------- CREACION DE VIEWS ----------------


-- VISTA 1
CREATE VIEW LOS_CRUD.BI_TicketPromedioMensual AS
SELECT 
    u.desc_ubicacion AS Ubicacion,
    t.tiempo_anio AS Anio,
    t.tiempo_mes AS Mes,
    AVG(total_ticket) AS TicketPromedioMensual
FROM LOS_CRUD.BI_Ticket
    JOIN LOS_CRUD.BI_TIEMPO t ON cod_tiempo = t.cod_tiempo
    JOIN LOS_CRUD.BI_UBICACION u ON cod_ubicacion = u.cod_ubicacion
GROUP BY 
    u.nombre_localidad, 
    t.tiempo_anio, 
    t.tiempo_mes;






---------------- SELECTS DE LAS VISTAS ----------------