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

IF EXISTS(SELECT [name] FROM sys.objects WHERE [name] = 'BI_CALCULAR_TIEMPO')
    DROP FUNCTION LOS_CRUD.BI_CALCULAR_TIEMPO;
GO

------------- LIMPIAR TABLAS ------------------------

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_Tickets')
    DROP TABLE LOS_CRUD.BI_Tickets;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_PromocionAplicada')
    DROP TABLE LOS_CRUD.BI_PromocionAplicada;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_Envios')
    DROP TABLE LOS_CRUD.BI_Envios;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_Pagos')
    DROP TABLE LOS_CRUD.BI_Pagos;

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

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_SUBCATEGORIA_PRODUCTO')
    DROP TABLE LOS_CRUD.BI_SUBCATEGORIA_PRODUCTO;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'BI_CATEGORIA_PRODUCTO')
    DROP TABLE LOS_CRUD.BI_CATEGORIA_PRODUCTO;

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

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_PROMOCION_APLICADA')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_PROMOCION_APLICADA;

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_CATEGORIA_PRODUCTO')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_CATEGORIA_PRODUCTO;


IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_SUBCATEGORIA_PRODUCTO')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_SUBCATEGORIA_PRODUCTO;


IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_TIPO_CAJA')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_TIPO_CAJA;

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_ENVIOS')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_ENVIOS;

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_PAGOS')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_PAGOS;

IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MIGRAR_BI_MDP')
    DROP PROCEDURE LOS_CRUD.MIGRAR_BI_MDP;
GO


---------------------- LIMPIAR VISTAS ----------------------

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_TicketPromedioMensual')
    DROP VIEW LOS_CRUD.BI_TicketPromedioMensual;

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_UnidadesPromedioPorTurnoYCuatrimestre')
    DROP VIEW LOS_CRUD.BI_UnidadesPromedioPorTurnoYCuatrimestre;

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_PorcentajeAnualDeVentas')
    DROP VIEW LOS_CRUD.BI_PorcentajeAnualDeVentas;

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_VentasPorTurno')
    DROP VIEW LOS_CRUD.BI_VentasPorTurno; 

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_PorcentajeDescuentoTicket')
    DROP VIEW LOS_CRUD.BI_PorcentajeDescuentoTicket; 

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_CategoriasMayorDescuento')
    DROP VIEW LOS_CRUD.BI_CategoriasMayorDescuento; 

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_PorcentajeCumplimientoEnvios')
    DROP VIEW LOS_CRUD.BI_PorcentajeCumplimientoEnvios; 

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_CantidadDeEnviosRangoEtarioCliente')
    DROP VIEW LOS_CRUD.BI_CantidadDeEnviosRangoEtarioCliente; 

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_LocalidadesConMayorCosto')
    DROP VIEW LOS_CRUD.BI_LocalidadesConMayorCosto; 

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_SucursalesConMayorImporteDePagosEnCuotas')
    DROP VIEW LOS_CRUD.BI_SucursalesConMayorImporteDePagosEnCuotas; 

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_PromedioImporteDeCuota')
    DROP VIEW LOS_CRUD.BI_PromedioImporteDeCuota; 

IF EXISTS (SELECT [name] FROM sys.views WHERE [name] = 'BI_PorcentajeDescuentoAplicadoPorMedioDePago')
    DROP VIEW LOS_CRUD.BI_PorcentajeDescuentoAplicadoPorMedioDePago; 
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

CREATE FUNCTION LOS_CRUD.BI_CALCULAR_TIEMPO(@FECHA_HORA DATETIME2(3))
RETURNS INT 
AS
BEGIN 
	DECLARE @cod_tiempo INT
	SELECT @cod_tiempo = cod_tiempo FROM LOS_CRUD.BI_TIEMPO WHERE YEAR(@FECHA_HORA) = tiempo_anio 
										AND MONTH(@FECHA_HORA) = tiempo_mes
	RETURN @cod_tiempo
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
	INSERT INTO LOS_CRUD.BI_SUBCATEGORIA_PRODUCTO (cod_subcategoria, cod_categoria, desc_subcategoria)
		SELECT DISTINCT cod_subcategoria, cod_categoria, nombre_subcategoria
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

CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_MDP
AS
BEGIN
	INSERT INTO LOS_CRUD.BI_MDP (cod_mdp, desc_mdp)
		SELECT DISTINCT cod_medio_pago, descripcion_medio_pago
		FROM LOS_CRUD.MedioPago
	END
GO


---------------- MIGRACIONES A TABLAS EXTRAS ----------------

---------------- MIGRACIONES A HECHOS ----------------
CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_TICKETS
AS
BEGIN
    INSERT INTO LOS_CRUD.BI_Tickets (
        cod_rango_etario_cliente, 
        cod_rango_etario_empleado, 
        cod_dia_ticket,
        cod_tiempo,
        cod_ubicacion,
        cod_rango_turnos,
        cod_tipo_caja,
        cantidad_articulos,
        total_ticket,
        descuento_aplicado_ticket
    )
    SELECT 
        LOS_CRUD.BI_CALCULAR_RANGO_ETARIO(c.fecha_nacimiento_cliente) AS cod_rango_etario_cliente,
        LOS_CRUD.BI_CALCULAR_RANGO_ETARIO(e.fecha_nacimiento_empleado) AS cod_rango_etario_empleado,
        bd.cod_dia,
        bt.cod_tiempo,
        bu.cod_ubicacion,
        LOS_CRUD.BI_CALCULAR_RANGO_TURNOS(t.fecha_hora_ticket) AS cod_rango_turnos,
        bc.cod_tipo_caja,
        SUM(td.cantidad) AS cantidad_articulos,
        t.total_ticket,
        t.total_descuento_aplicado + t.total_descuento_aplicado_mp AS descuento_aplicado_ticket
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
        t.cod_ticket,
        LOS_CRUD.BI_CALCULAR_RANGO_ETARIO(c.fecha_nacimiento_cliente),
        LOS_CRUD.BI_CALCULAR_RANGO_ETARIO(e.fecha_nacimiento_empleado),
        bd.cod_dia,
        bt.cod_tiempo,
        bu.cod_ubicacion,
        LOS_CRUD.BI_CALCULAR_RANGO_TURNOS(t.fecha_hora_ticket),
        bc.cod_tipo_caja,
        t.total_ticket,
        t.total_descuento_aplicado + t.total_descuento_aplicado_mp
END
GO

CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_PAGOS
AS
BEGIN
    INSERT INTO LOS_CRUD.BI_Pagos (cod_sucursal, cod_tiempo, cod_rango_etario_cliente, total_importe_pago, total_monto_descontado, total_cuotas, cod_mdp)
    SELECT 
        s.cod_sucursal,
        tt.cod_tiempo,
        LOS_CRUD.BI_CALCULAR_RANGO_ETARIO(cli.fecha_nacimiento_cliente) as cod_rango_etario_cliente,
        SUM(p.importe_pago) AS total_importe_pago,
        SUM(p.monto_descontado) AS total_monto_descontado,
        SUM(p.cuotas_tarjeta) AS total_cuotas,
        mp.cod_mdp
    FROM LOS_CRUD.Pago p
    JOIN LOS_CRUD.Ticket t ON p.cod_ticket = t.cod_ticket
    JOIN LOS_CRUD.Caja c ON t.cod_caja = c.cod_caja
    JOIN LOS_CRUD.BI_SUCURSAL s ON s.cod_sucursal = c.cod_sucursal 
    JOIN LOS_CRUD.BI_TIEMPO tt ON YEAR(p.fecha_pago) = tt.tiempo_anio AND MONTH(p.fecha_pago) = tt.tiempo_mes
    JOIN LOS_CRUD.BI_MDP mp ON mp.cod_mdp = p.cod_medio_pago
    JOIN LOS_CRUD.Cliente cli ON t.cod_cliente = cli.cod_cliente
    GROUP BY s.cod_sucursal, tt.cod_tiempo, LOS_CRUD.BI_CALCULAR_RANGO_ETARIO(cli.fecha_nacimiento_cliente), mp.cod_mdp
END
GO


CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_ENVIOS
AS
BEGIN
    INSERT INTO LOS_CRUD.BI_Envios (
        cod_sucursal, 
        cod_ubicacion,
        cod_rango_etario_cliente, 
		cod_tiempo_programado,
		cod_tiempo_entrega,
        total_envios,
        costo_total_envios
    )
    SELECT 
        s.cod_sucursal,
        u.cod_ubicacion,
        LOS_CRUD.BI_CALCULAR_RANGO_ETARIO(cli.fecha_nacimiento_cliente) AS cod_rango_etario_cliente,
		LOS_CRUD.BI_CALCULAR_TIEMPO(e.fecha_programada_envio) AS cod_tiempo_programado,
		LOS_CRUD.BI_CALCULAR_TIEMPO(e.fecha_entrega_envio) AS cod_tiempo_entrega, 
        COUNT(e.cod_envio) AS total_envios,
        SUM(e.costo_envio) AS costo_total_envios
    FROM 
        LOS_CRUD.Envio e
        JOIN LOS_CRUD.Ticket t ON e.cod_ticket = t.cod_ticket
        JOIN LOS_CRUD.Caja c ON t.cod_caja = c.cod_caja
        JOIN LOS_CRUD.BI_SUCURSAL s ON s.cod_sucursal = c.cod_sucursal
        JOIN LOS_CRUD.Cliente cli ON t.cod_cliente = cli.cod_cliente
        JOIN LOS_CRUD.BI_UBICACION u ON LOS_CRUD.BI_CALCULAR_UBICACION(cli.cod_localidad) = u.desc_ubicacion
    GROUP BY 
        s.cod_sucursal,
        u.cod_ubicacion,
        LOS_CRUD.BI_CALCULAR_RANGO_ETARIO(cli.fecha_nacimiento_cliente),
		LOS_CRUD.BI_CALCULAR_TIEMPO(e.fecha_programada_envio),
		LOS_CRUD.BI_CALCULAR_TIEMPO(e.fecha_entrega_envio)
END
GO


CREATE PROCEDURE LOS_CRUD.MIGRAR_BI_PROMOCION_APLICADA
AS
BEGIN
    INSERT INTO LOS_CRUD.BI_PromocionAplicada (cod_categoria, cod_tiempo, total_descuento_aplicado)
    SELECT 
        sc.cod_categoria,
        t.cod_tiempo,
        SUM(p.descuento_aplicado) AS total_descuento_aplicado
    FROM LOS_CRUD.PromocionAplicada p
    JOIN LOS_CRUD.Producto prod ON prod.cod_producto = p.cod_producto
    JOIN LOS_CRUD.BI_SUBCATEGORIA_PRODUCTO sc ON sc.cod_subcategoria = prod.cod_subcategoria
    JOIN LOS_CRUD.TicketDetalle td ON td.cod_ticket_detalle = p.cod_ticket_detalle
    JOIN LOS_CRUD.Ticket bt ON bt.cod_ticket = td.cod_ticket
    JOIN LOS_CRUD.BI_TIEMPO t ON YEAR(bt.fecha_hora_ticket) = t.tiempo_anio AND MONTH(bt.fecha_hora_ticket) = t.tiempo_mes
    GROUP BY sc.cod_categoria, t.cod_tiempo
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
	cod_categoria INT FOREIGN KEY REFERENCES LOS_CRUD.BI_CATEGORIA_PRODUCTO,
    desc_subcategoria NVARCHAR(50) NOT NULL
);

-- Tipo de caja
CREATE TABLE LOS_CRUD.BI_TIPO_CAJA(
    cod_tipo_caja INT PRIMARY KEY,
    desc_tipo_caja NVARCHAR(50) NOT NULL
);

---------------- TABLAS DE HECHOS ----------------


CREATE TABLE LOS_CRUD.BI_Tickets (
    cod_rango_etario_cliente INT FOREIGN KEY REFERENCES LOS_CRUD.BI_RANGO_ETARIO(cod_rango_etario),
    cod_rango_etario_empleado INT FOREIGN KEY REFERENCES LOS_CRUD.BI_RANGO_ETARIO(cod_rango_etario),
    cod_dia_ticket INT FOREIGN KEY REFERENCES LOS_CRUD.BI_DIAS(cod_dia),
    cod_tiempo INT FOREIGN KEY REFERENCES LOS_CRUD.BI_TIEMPO(cod_tiempo),
    cod_ubicacion INT FOREIGN KEY REFERENCES LOS_CRUD.BI_UBICACION(cod_ubicacion),
    cod_rango_turnos INT FOREIGN KEY REFERENCES LOS_CRUD.BI_RANGO_TURNOS(cod_rango_turnos),
    cod_tipo_caja INT FOREIGN KEY REFERENCES LOS_CRUD.BI_TIPO_CAJA(cod_tipo_caja),
    cantidad_articulos DECIMAL(10, 2),
    total_ticket DECIMAL(10, 2) NOT NULL,
    descuento_aplicado_ticket DECIMAL(10, 2) NOT NULL
);


CREATE TABLE LOS_CRUD.BI_PromocionAplicada (
    cod_categoria INT FOREIGN KEY REFERENCES LOS_CRUD.BI_CATEGORIA_PRODUCTO,
    cod_tiempo INT FOREIGN KEY REFERENCES LOS_CRUD.BI_TIEMPO,
    total_descuento_aplicado DECIMAL(18,2)
);

CREATE TABLE LOS_CRUD.BI_Envios(
    cod_sucursal INT FOREIGN KEY REFERENCES LOS_CRUD.BI_SUCURSAL,
    cod_ubicacion INT FOREIGN KEY REFERENCES LOS_CRUD.BI_UBICACION,
    cod_rango_etario_cliente INT FOREIGN KEY REFERENCES LOS_CRUD.BI_RANGO_ETARIO,
    cod_tiempo_programado INT FOREIGN KEY REFERENCES LOS_CRUD.BI_TIEMPO,
    cod_tiempo_entrega INT FOREIGN KEY REFERENCES LOS_CRUD.BI_TIEMPO,
    total_envios INT,
    costo_total_envios DECIMAL(18, 2)
);

CREATE TABLE LOS_CRUD.BI_Pagos(
    cod_sucursal INT FOREIGN KEY REFERENCES LOS_CRUD.BI_SUCURSAL,
    cod_tiempo INT FOREIGN KEY REFERENCES LOS_CRUD.BI_TIEMPO,
    cod_rango_etario_cliente INT FOREIGN KEY REFERENCES LOS_CRUD.BI_RANGO_ETARIO,
    total_importe_pago DECIMAL(18,2),
    total_monto_descontado DECIMAL(18,2),
    total_cuotas INT,
    cod_mdp INT FOREIGN KEY REFERENCES LOS_CRUD.BI_MDP
);

---------------- EXECUTES ----------------

EXEC LOS_CRUD.MIGRAR_BI_MDP;

EXEC LOS_CRUD.MIGRAR_BI_UBICACION;

EXEC LOS_CRUD.MIGRAR_BI_RANGO_ETARIO;

EXEC LOS_CRUD.MIGRAR_BI_DIAS;

EXEC LOS_CRUD.MIGRAR_BI_TIEMPO;

EXEC LOS_CRUD.MIGRAR_BI_RANGO_TURNOS;

EXEC LOS_CRUD.MIGRAR_BI_SUCURSAL;

EXEC LOS_CRUD.MIGRAR_BI_CATEGORIA_PRODUCTO;

EXEC LOS_CRUD.MIGRAR_BI_SUBCATEGORIA_PRODUCTO;

EXEC LOS_CRUD.MIGRAR_BI_TIPO_CAJA;

EXEC LOS_CRUD.MIGRAR_BI_TICKETS;

EXEC LOS_CRUD.MIGRAR_BI_PROMOCION_APLICADA;

EXEC LOS_CRUD.MIGRAR_BI_ENVIOS;

EXEC LOS_CRUD.MIGRAR_BI_PAGOS;

Print 'Executes realizados'
GO
---------------- CREACION DE VIEWS ----------------



-- 1. Ticket promedio mensual
CREATE VIEW LOS_CRUD.BI_TicketPromedioMensual AS
SELECT 
    u.desc_ubicacion,
    t.tiempo_anio,
    t.tiempo_mes,
    AVG(bt.total_ticket) AS ticket_promedio_mensual
FROM LOS_CRUD.BI_Tickets bt
JOIN LOS_CRUD.BI_UBICACION u ON bt.cod_ubicacion = u.cod_ubicacion
JOIN LOS_CRUD.BI_TIEMPO t ON bt.cod_tiempo = t.cod_tiempo
GROUP BY u.desc_ubicacion, t.tiempo_anio, t.tiempo_mes;
GO

--2 Cantidad de unidades promedio
CREATE VIEW LOS_CRUD.BI_UnidadesPromedioPorTurnoYCuatrimestre AS
SELECT 
    rt.desc_rango_turnos,
    t.tiempo_anio,
    t.tiempo_cuatrimestre,
    AVG(bt.cantidad_articulos) AS cantidad_unidades_promedio
FROM LOS_CRUD.BI_Tickets bt
JOIN LOS_CRUD.BI_RANGO_TURNOS rt ON bt.cod_rango_turnos = rt.cod_rango_turnos
JOIN LOS_CRUD.BI_TIEMPO t ON bt.cod_tiempo = t.cod_tiempo
GROUP BY rt.desc_rango_turnos, t.tiempo_anio, t.tiempo_cuatrimestre;
GO	

--3 Porcentaje anual de ventas
CREATE VIEW LOS_CRUD.BI_PorcentajeAnualDeVentas AS
	SELECT
		br.desc_rango_etario AS Edad,
		bc.desc_tipo_caja AS Tipo_caja,
		bt.tiempo_cuatrimestre AS Cuatrimestre,
		bt.tiempo_anio AS Anio,
		(CAST(COUNT(br.desc_rango_etario) AS DECIMAL(6, 2)) / (SELECT COUNT(*) FROM LOS_CRUD.BI_Tickets)) * 100 AS PorcentajeAnualDeVentas
	FROM LOS_CRUD.BI_Tickets t
		JOIN LOS_CRUD.BI_RANGO_ETARIO br ON br.cod_rango_etario = t.cod_rango_etario_empleado
		JOIN LOS_CRUD.BI_TIPO_CAJA bc ON bc.cod_tipo_caja = t.cod_tipo_caja
		JOIN LOS_CRUD.BI_TIEMPO bt ON bt.cod_tiempo = t.cod_tiempo
	GROUP BY
		bt.tiempo_anio,
		bt.tiempo_cuatrimestre,
		br.desc_rango_etario,
		bc.desc_tipo_caja
GO
		
--4 Cantidad de ventas registradas por turno
		
CREATE VIEW LOS_CRUD.BI_VentasPorTurno AS
	SELECT 
    u.desc_ubicacion,
    rt.desc_rango_turnos,
    t.tiempo_anio,
    t.tiempo_mes,
    COUNT(*) AS cantidad_ventas
FROM LOS_CRUD.BI_Tickets bt
JOIN LOS_CRUD.BI_UBICACION u ON bt.cod_ubicacion = u.cod_ubicacion
JOIN LOS_CRUD.BI_RANGO_TURNOS rt ON bt.cod_rango_turnos = rt.cod_rango_turnos
JOIN LOS_CRUD.BI_TIEMPO t ON bt.cod_tiempo = t.cod_tiempo
GROUP BY u.desc_ubicacion, rt.desc_rango_turnos, t.tiempo_anio, t.tiempo_mes;
GO
--5 Porcentaje de descuento aplicados en función del total de los tickets

CREATE VIEW LOS_CRUD.BI_PorcentajeDescuentoTicket AS
	SELECT 
    t.tiempo_anio,
    t.tiempo_mes,
    SUM(bt.descuento_aplicado_ticket) * 100.0 / SUM(bt.total_ticket) AS porcentaje_descuento
FROM LOS_CRUD.BI_Tickets bt
JOIN LOS_CRUD.BI_TIEMPO t ON bt.cod_tiempo = t.cod_tiempo
GROUP BY t.tiempo_anio, t.tiempo_mes;
GO

-- 6
CREATE VIEW LOS_CRUD.BI_CategoriasMayorDescuento AS
WITH CategoriaDescuento AS (
    SELECT 
        sc.cod_categoria,
        t.tiempo_anio,
        t.tiempo_cuatrimestre,
        SUM(pa.total_descuento_aplicado) AS total_descuento
    FROM LOS_CRUD.BI_PromocionAplicada pa
    JOIN LOS_CRUD.BI_TIEMPO t ON pa.cod_tiempo = t.cod_tiempo
    JOIN LOS_CRUD.BI_CATEGORIA_PRODUCTO sc ON pa.cod_categoria = sc.cod_categoria
    GROUP BY sc.cod_categoria, t.tiempo_anio, t.tiempo_cuatrimestre
)
SELECT 
    cod_categoria,
    tiempo_anio,
    tiempo_cuatrimestre,
    total_descuento
FROM (
    SELECT 
        cod_categoria,
        tiempo_anio,
        tiempo_cuatrimestre,
        total_descuento,
        ROW_NUMBER() OVER (PARTITION BY tiempo_anio, tiempo_cuatrimestre ORDER BY total_descuento DESC) AS rn
    FROM CategoriaDescuento
) AS sub
WHERE rn <= 3;
GO
--7 
CREATE VIEW LOS_CRUD.BI_PorcentajeCumplimientoEnvios AS
	SELECT 
    s.nombre_sucursal,
    t.tiempo_anio,
    t.tiempo_mes,
    SUM(CASE WHEN e.cod_tiempo_entrega <= e.cod_tiempo_programado THEN 1 ELSE 0 END) * 100.0 / COUNT(e.cod_tiempo_entrega) AS porcentaje_cumplimiento
FROM LOS_CRUD.BI_Envios e
JOIN LOS_CRUD.BI_SUCURSAL s ON e.cod_sucursal = s.cod_sucursal
JOIN LOS_CRUD.BI_TIEMPO t ON e.cod_tiempo_programado = t.cod_tiempo
GROUP BY s.nombre_sucursal, t.tiempo_anio, t.tiempo_mes;
GO

--8
CREATE VIEW LOS_CRUD.BI_CantidadDeEnviosRangoEtarioCliente AS
SELECT 
    re.desc_rango_etario,
    t.tiempo_anio,
    t.tiempo_cuatrimestre,
    COUNT(e.cod_tiempo_programado) AS cantidad_envios
FROM LOS_CRUD.BI_Envios e
JOIN LOS_CRUD.BI_RANGO_ETARIO re ON e.cod_rango_etario_cliente = re.cod_rango_etario
JOIN LOS_CRUD.BI_TIEMPO t ON e.cod_tiempo_programado = t.cod_tiempo
GROUP BY re.desc_rango_etario, t.tiempo_anio, t.tiempo_cuatrimestre;
GO

--9
CREATE VIEW LOS_CRUD.BI_LocalidadesConMayorCosto AS
WITH LocalidadCosto AS (
    SELECT 
        u.desc_ubicacion,
        SUM(e.costo_total_envios) AS total_costo_envios,
        ROW_NUMBER() OVER (ORDER BY SUM(e.costo_total_envios) DESC) AS rn
    FROM LOS_CRUD.BI_Envios e
    JOIN LOS_CRUD.BI_UBICACION u ON e.cod_ubicacion = u.cod_ubicacion
    GROUP BY u.desc_ubicacion
)
SELECT 
    desc_ubicacion,
    total_costo_envios
FROM LocalidadCosto
WHERE rn <= 5;
GO

--10 
CREATE VIEW LOS_CRUD.BI_SucursalesConMayorImporteDePagosEnCuotas AS
	WITH SucursalPagos AS (
    SELECT 
        s.nombre_sucursal,
        mp.desc_mdp,
        t.tiempo_anio,
        t.tiempo_mes,
        SUM(p.total_importe_pago) AS total_importe_pagos
    FROM LOS_CRUD.BI_Pagos p
    JOIN LOS_CRUD.BI_SUCURSAL s ON p.cod_sucursal = s.cod_sucursal
    JOIN LOS_CRUD.BI_MDP mp ON p.cod_mdp = mp.cod_mdp
    JOIN LOS_CRUD.BI_TIEMPO t ON p.cod_tiempo = t.cod_tiempo
    GROUP BY s.nombre_sucursal, mp.desc_mdp, t.tiempo_anio, t.tiempo_mes
)
SELECT 
    nombre_sucursal,
    desc_mdp,
    tiempo_anio,
    tiempo_mes,
    total_importe_pagos
FROM (
    SELECT 
        nombre_sucursal,
        desc_mdp,
        tiempo_anio,
        tiempo_mes,
        total_importe_pagos,
        ROW_NUMBER() OVER (PARTITION BY tiempo_anio, tiempo_mes, desc_mdp ORDER BY total_importe_pagos DESC) AS rn
    FROM SucursalPagos
) AS sub
WHERE rn <= 3;
GO

--11
CREATE VIEW LOS_CRUD.BI_PromedioImporteDeCuota AS
	SELECT 
    re.desc_rango_etario,
    AVG(p.total_importe_pago / p.total_cuotas) AS promedio_importe_cuota
FROM LOS_CRUD.BI_Pagos p
JOIN LOS_CRUD.BI_RANGO_ETARIO re ON p.cod_rango_etario_cliente = re.cod_rango_etario
GROUP BY re.desc_rango_etario;
GO

--12
CREATE VIEW LOS_CRUD.BI_PorcentajeDescuentoAplicadoPorMedioDePago AS
	SELECT 
    mp.desc_mdp,
    t.tiempo_anio,
    t.tiempo_cuatrimestre,
    SUM(p.total_monto_descontado) * 100.0 / SUM(p.total_importe_pago + p.total_monto_descontado) AS porcentaje_descuento
FROM LOS_CRUD.BI_Pagos p
JOIN LOS_CRUD.BI_MDP mp ON p.cod_mdp = mp.cod_mdp
JOIN LOS_CRUD.BI_TIEMPO t ON p.cod_tiempo = t.cod_tiempo
GROUP BY mp.desc_mdp, t.tiempo_anio, t.tiempo_cuatrimestre;
GO
---------------- SELECTS DE LAS VISTAS ----------------
SELECT * from LOS_CRUD.BI_TicketPromedioMensual 	
ORDER BY tiempo_anio, tiempo_mes;

SELECT * from LOS_CRUD.BI_UnidadesPromedioPorTurnoYCuatrimestre
ORDER BY tiempo_cuatrimestre, desc_rango_turnos;

SELECT * from LOS_CRUD.BI_PorcentajeAnualDeVentas
ORDER BY Cuatrimestre, Edad, Tipo_caja, Anio, PorcentajeAnualDeVentas;

SELECT * from LOS_CRUD.BI_VentasPorTurno
ORDER BY desc_rango_turnos, desc_ubicacion, tiempo_anio, tiempo_mes;

SELECT * from LOS_CRUD.BI_PorcentajeDescuentoTicket

SELECT * from LOS_CRUD.BI_CategoriasMayorDescuento
order by cod_categoria ASC, tiempo_cuatrimestre ASC

SELECT * FROM LOS_CRUD.BI_PorcentajeCumplimientoEnvios

SELECT * FROM LOS_CRUD.BI_CantidadDeEnviosRangoEtarioCliente 
ORDER BY desc_rango_etario DESC, tiempo_cuatrimestre 	

SELECT  * FROM LOS_CRUD.BI_LocalidadesConMayorCosto 
ORDER BY total_costo_envios DESC

SELECT TOP 3 * FROM LOS_CRUD.BI_SucursalesConMayorImporteDePagosEnCuotas
ORDER BY total_importe_pagos DESC

SELECT * FROM LOS_CRUD.BI_PromedioImporteDeCuota	

SELECT * FROM LOS_CRUD.BI_PorcentajeDescuentoAplicadoPorMedioDePago
ORDER BY desc_mdp, tiempo_cuatrimestre
