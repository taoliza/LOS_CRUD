USE [GD1C2024]
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

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_Tickets')
    DROP TABLE LOS_CRUD.BI_Tickets;

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

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_TIPO_CAJA')
    DROP TABLE LOS_CRUD.BI_TIPO_CAJA;
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

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_CATEGORIA_PRODUCTO')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_CATEGORIA_PRODUCTO;
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_SUBCATEGORIA_PRODUCTO')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_SUBCATEGORIA_PRODUCTO;
GO

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_TIPO_CAJA')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_TIPO_CAJA;
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

    -- Asignar el nombre de la provincia a la variable @PROVINCIA
    SELECT @PROVINCIA = p.nombre_provincia
    FROM LOS_CRUD.Localidad l
    JOIN LOS_CRUD.Provincia p ON p.cod_provincia = l.cod_provincia
    WHERE l.cod_localidad = @cod_localidad

    -- Asignar el nombre de la localidad a la variable @LOCALIDAD
    SELECT @LOCALIDAD = l.nombre_localidad
    FROM LOS_CRUD.Localidad l
    WHERE l.cod_localidad = @cod_localidad

    -- Concatenar localidad y provincia en la variable @UBICACION
    SET @UBICACION = @LOCALIDAD + ', ' + @PROVINCIA

    RETURN @UBICACION
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
		SELECT DISTINCT YEAR(fecha_hora_ticket),DATEPART(QUARTER, fecha_hora_ticket), MONTH(fecha_hora_ticket)
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
		SELECT DISTINCT cod_sucursal, nombre_sucursal, LOS_CRUD.BI_CALCULAR_UBICACION(cod_localidad) AS desc_ubicacion
		FROM LOS_CRUD.Sucursal
  END
GO

-- Categoria de productos
CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_CATEGORIA_PRODUCTO
AS
BEGIN
	INSERT INTO LOS_CRUD.BI_CATEGORIA_PRODUCTO (cod_categoria, desc_categoria)
		SELECT DISTINCT cod_categoria, nombre_categoria
		FROM LOS_CRUD.Categoria
	END
GO

CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_SUBCATEGORIA_PRODUCTO
AS
BEGIN
	INSERT INTO LOS_CRUD.BI_SUBCATEGORIA_PRODUCTO (cod_subcategoria, desc_subcategoria)
		SELECT DISTINCT cod_subcategoria, nombre_subcategoria
		FROM LOS_CRUD.SubCategoria
	END
GO

CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_TIPO_CAJA
AS
BEGIN
	INSERT INTO LOS_CRUD.BI_TIPO_CAJA (cod_tipo_caja, desc_tipo_caja)
		SELECT DISTINCT cod_tipo_caja, tipo_caja
		FROM LOS_CRUD.TipoCaja
	END
GO

---------------- MIGRACIONES A TABLAS EXTRAS ----------------

---------------- MIGRACIONES A HECHOS ----------------
CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_TICKETS
 AS
  BEGIN
    INSERT INTO LOS_CRUD.BI_Tickets (cod_rango_etario_cliente, 
	                                cod_rango_etario_empleado, 
                                    cod_dia_ticket,
                                    cod_tiempo,
									cod_ubicacion,
									cod_rango_turnos,
									cod_tipo_caja,
									cantidad_articulos,
                                    total_ticket)
		SELECT DISTINCT LOS_CRUD.BI_CALCULAR_RANGO_ETARIO(c.fecha_nacimiento_cliente) AS cod_rango_etario_cliente,
			LOS_CRUD.BI_CALCULAR_RANGO_ETARIO(e.fecha_nacimiento_empleado) AS cod_rango_etario_empleado,
			bd.cod_dia,
			bt.cod_tiempo,
			bu.cod_ubicacion,
			LOS_CRUD.BI_CALCULAR_RANGO_TURNOS(t.fecha_hora_ticket) AS cod_rango_turno,
			bc.cod_tipo_caja,
			SUM(td.cantidad) AS cantidad_articulos,
			t.total_ticket 
		FROM LOS_CRUD.Ticket t
		JOIN LOS_CRUD.Cliente c ON t.cod_cliente = c.cod_cliente
		JOIN LOS_CRUD.Empleado e ON t.cod_empleado = e.legajo_empleado
		JOIN LOS_CRUD.BI_TIEMPO bt ON YEAR(t.fecha_hora_ticket) = bt.tiempo_anio AND MONTH(t.fecha_hora_ticket) = bt.tiempo_mes
		JOIN LOS_CRUD.BI_DIAS bd ON LOS_CRUD.BI_CALCULAR_DIA_SEMANA(t.fecha_hora_ticket) = bd.desc_dia
		JOIN LOS_CRUD.Sucursal s ON e.cod_sucursal = s.cod_sucursal
		JOIN LOS_CRUD.BI_UBICACION bu ON LOS_CRUD.BI_CALCULAR_UBICACION(s.cod_localidad) = bu.desc_ubicacion
		JOIN LOS_CRUD.TicketDetalle td ON td.cod_ticket = t.cod_ticket
		JOIN LOS_CRUD.Caja caja ON t.cod_caja = caja.cod_caja
		JOIN LOS_CRUD.BI_TIPO_CAJA bc ON caja.cod_tipo_caja = bc.cod_tipo_caja 
		GROUP BY 
			c.fecha_nacimiento_cliente,
			e.fecha_nacimiento_empleado,
			bd.cod_dia,
			bt.cod_tiempo,
			bu.cod_ubicacion,
			t.fecha_hora_ticket,
			t.total_ticket,
			bc.cod_tipo_caja
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
    cod_rango_turnos INT PRIMARY KEY,
    desc_rango_turnos NVARCHAR(50) NOT NULL
);

-- Sucursal
CREATE TABLE LOS_CRUD.BI_SUCURSAL(
    cod_sucursal INT PRIMARY KEY,
    nombre_sucursal NVARCHAR(255),
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

CREATE TABLE LOS_CRUD.BI_TIPO_CAJA(
    cod_tipo_caja INT PRIMARY KEY,
    desc_tipo_caja NVARCHAR(50) NOT NULL
);

---------------- TABLAS DE HECHOS ----------------


CREATE TABLE LOS_CRUD.BI_Tickets (
    
    cod_rango_etario_cliente INT, 
	cod_rango_etario_empleado INT FOREIGN KEY REFERENCES LOS_CRUD.BI_RANGO_ETARIO, 
    cod_dia_ticket INT FOREIGN KEY REFERENCES LOS_CRUD.BI_DIAS,
    cod_tiempo INT FOREIGN KEY REFERENCES LOS_CRUD.BI_TIEMPO,
	cod_ubicacion INT FOREIGN KEY REFERENCES LOS_CRUD.BI_UBICACION,
	cod_rango_turnos INT FOREIGN KEY REFERENCES LOS_CRUD.BI_RANGO_TURNOS,
	cod_tipo_caja INT FOREIGN KEY REFERENCES LOS_CRUD.BI_TIPO_CAJA,
	cantidad_articulos DECIMAL(10,2),
    total_ticket DECIMAL(10,2) NOT NULL
    FOREIGN KEY (cod_rango_etario_cliente) REFERENCES LOS_CRUD.BI_RANGO_ETARIO,
    FOREIGN KEY (cod_rango_etario_empleado) REFERENCES LOS_CRUD.BI_RANGO_ETARIO,
    FOREIGN KEY (cod_dia_ticket) REFERENCES LOS_CRUD.BI_DIAS,
    FOREIGN KEY (cod_tiempo) REFERENCES LOS_CRUD.BI_TIEMPO,
	FOREIGN KEY (cod_ubicacion) REFERENCES LOS_CRUD.BI_UBICACION,
	FOREIGN KEY (cod_rango_turnos) REFERENCES LOS_CRUD.BI_RANGO_TURNOS,
	FOREIGN KEY (cod_tipo_caja) REFERENCES LOS_CRUD.BI_TIPO_CAJA
);


---------------- EXECUTES ----------------

-- Ejecutar la migración de BI_UBICACION
EXEC LOS_CRUD.MIGRAR_BI_UBICACION;

-- Ejecutar la migración de BI_RANGO_ETARIO
EXEC LOS_CRUD.MIGRAR_BI_RANGO_ETARIO;

-- Ejecutar la migración de BI_DIAS
EXEC LOS_CRUD.MIGRAR_BI_DIAS;

-- Ejecutar la migración de BI_TIEMPO
EXEC LOS_CRUD.MIGRAR_BI_TIEMPO;

-- Ejecutar la migración de BI_RANGO_TURNOS
EXEC LOS_CRUD.MIGRAR_BI_RANGO_TURNOS;

-- Ejecutar la migración de BI_SUCURSAL
EXEC LOS_CRUD.MIGRAR_BI_SUCURSAL;

-- Ejecutar la migración de BI_TICKETS
EXEC LOS_CRUD.MIGRAR_BI_TICKETS;

EXEC LOS_CRUD.MIGRAR_BI_CATEGORIA_PRODUCTO;

EXEC LOS_CRUD.MIGRAR_BI_SUBCATEGORIA_PRODUCTO;

EXEC LOS_CRUD.MIGRAR_BI_TIPO_CAJA;

---------------- CREACION DE VIEWS ----------------


-- VISTA 1
-- 1. Ticket promedio mensual
/*CREATE VIEW LOS_CRUD.BI_TicketPromedioMensual AS
	SELECT 
		u.desc_ubicacion AS Ubicacion,
		t.tiempo_anio AS Anio,
		t.tiempo_mes AS Mes,
		AVG(total_ticket) AS TicketPromedioMensual
	FROM LOS_CRUD.BI_Tickets bt
		JOIN LOS_CRUD.BI_TIEMPO t ON bt.cod_tiempo = t.cod_tiempo
		JOIN LOS_CRUD.BI_UBICACION u ON bt.cod_ubicacion = u.cod_ubicacion
	GROUP BY 
		u.desc_ubicacion, 
		t.tiempo_anio, 
		t.tiempo_mes;

--2 Cantidad de unidades promedio
CREATE VIEW LOS_CRUD.BI_UnidadesPromedioPorTurnoYCuatrimestre AS
	SELECT DISTINCT
		t.tiempo_cuatrimestre,
		brt.desc_rango_turnos,
		AVG(bt.cantidad_articulos) AS unidades_promedio
	FROM LOS_CRUD.BI_Tickets bt
		JOIN LOS_CRUD.BI_TIEMPO t ON bt.cod_tiempo = t.cod_tiempo
		JOIN LOS_CRUD.BI_RANGO_TURNOS brt ON bt.cod_rango_turnos = brt.cod_rango_turnos
	GROUP BY
		t.tiempo_cuatrimestre,
		brt.desc_rango_turnos;*/
	
--3 Porcentaje anual de ventas
/*CREATE VIEW LOS_CRUD.BI_PorcentajeAnualDeVentas
	SELECT
		br.desc_rango_etario,
		bc.desc_tipo_caja,
		bt.tiempo_cuatrimestre,
		bt.tiempo_anio,
		(CAST(COUNT(br.desc_rango_etario) AS DECIMAL(6, 2)) / (SELECT COUNT(*) FROM LOS_CRUD.BI_Tickets)) * 100 AS PorcentajeAnualDeVentas
	FROM LOS_CRUD.BI_Tickets t
		JOIN LOS_CRUD.BI_RANGO_ETARIO br ON br.cod_rango_etario = t.cod_rango_etario_empleado
		JOIN LOS_CRUD.BI_TIPO_CAJA bc ON bc.cod_tipo_caja = t.cod_tipo_caja
		JOIN LOS_CRUD.BI_TIEMPO bt ON bt.cod_tiempo = t.cod_tiempo
	GROUP BY
		br.desc_rango_etario,
		bc.desc_tipo_caja,
		bt.tiempo_cuatrimestre,
		bt.tiempo_anio*/




---------------- SELECTS DE LAS VISTAS ----------------
