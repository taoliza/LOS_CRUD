USE [GD1C2024]
GO
CREATE SCHEMA [LOS_CRUD]
GO

/*
select * from gd_esquema.Maestra
where CLIENTE_LOCALIDAD = 'Mar del Plata'*/

--Drops procedures
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarProvincias')
	DROP PROCEDURE LOS_CRUD.MigrarProvincias;
IF EXISTS(SELECT [name] FROM sys.procedures WHERE [name] = 'MigrarProvincias')
	DROP PROCEDURE LOS_CRUD.MigrarProvincias;
GO


--Drops tablas
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'PromocionReglas')
    DROP TABLE LOS_CRUD.PromocionReglas;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Reglas')
    DROP TABLE LOS_CRUD.Reglas;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Super')
    DROP TABLE LOS_CRUD.Super;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'TicketDetalle')
    DROP TABLE LOS_CRUD.TicketDetalle;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Descuento')
    DROP TABLE LOS_CRUD.Descuento;    
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'PromocionAplicada')
    DROP TABLE LOS_CRUD.PromocionAplicada;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'PromocionProducto')
    DROP TABLE LOS_CRUD.PromocionProducto;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Promocion')
    DROP TABLE LOS_CRUD.Promocion;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Pago')
    DROP TABLE LOS_CRUD.Pago;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Envio')
    DROP TABLE LOS_CRUD.Envio;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Ticket')
    DROP TABLE LOS_CRUD.Ticket;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Empleado')
    DROP TABLE LOS_CRUD.Empleado;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'TipoDeComprobante')
    DROP TABLE LOS_CRUD.TipoDeComprobante;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Producto')
    DROP TABLE LOS_CRUD.Producto;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Subcategoria')
    DROP TABLE LOS_CRUD.Subcategoria;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Categoria')
    DROP TABLE LOS_CRUD.Categoria;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Marca')
    DROP TABLE LOS_CRUD.Marca;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'MedioPago')
    DROP TABLE LOS_CRUD.MedioPago;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Caja')
    DROP TABLE LOS_CRUD.Caja;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'TipoCaja')
    DROP TABLE LOS_CRUD.TipoCaja;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Cliente')
    DROP TABLE LOS_CRUD.Cliente;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Sucursal')
    DROP TABLE LOS_CRUD.Sucursal;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Localidad')
    DROP TABLE LOS_CRUD.Localidad;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'Provincia')
    DROP TABLE LOS_CRUD.Provincia;
GO

-- MIGRACION DE DATOS --
-- STORED PROCEDURES

--Provincias
CREATE PROCEDURE LOS_CRUD.MigrarProvincias
AS
BEGIN
    INSERT INTO LOS_CRUD.Provincia (nombre_provincia)
    SELECT DISTINCT SUPER_PROVINCIA
    FROM gd_esquema.Maestra
    WHERE SUPER_PROVINCIA IS NOT NULL
    UNION
    SELECT DISTINCT CLIENTE_PROVINCIA
    FROM gd_esquema.Maestra
    WHERE CLIENTE_PROVINCIA IS NOT NULL
    UNION
    SELECT DISTINCT SUCURSAL_PROVINCIA
    FROM gd_esquema.Maestra
    WHERE SUCURSAL_PROVINCIA IS NOT NULL;
END
GO

--Localidad
CREATE PROCEDURE LOS_CRUD.MigrarLocalidades
AS
BEGIN
    INSERT INTO LOS_CRUD.Localidad (nombre_localidad, cod_provincia)
    SELECT DISTINCT SUPER_LOCALIDAD,p.cod_provincia
    FROM gd_esquema.Maestra m
    JOIN LOS_CRUD.Provincia p ON m.SUPER_PROVINCIA = p.nombre_provincia
    WHERE SUPER_LOCALIDAD IS NOT NULL
    UNION
    SELECT DISTINCT CLIENTE_LOCALIDAD,p.cod_provincia
    FROM gd_esquema.Maestra m
    JOIN LOS_CRUD.Provincia p ON m.CLIENTE_PROVINCIA = p.nombre_provincia
    WHERE CLIENTE_LOCALIDAD IS NOT NULL
    UNION
    SELECT DISTINCT SUCURSAL_LOCALIDAD,p.cod_provincia
    FROM gd_esquema.Maestra m
    JOIN LOS_CRUD.Provincia p ON m.SUCURSAL_PROVINCIA = p.nombre_provincia
    WHERE SUCURSAL_LOCALIDAD IS NOT NULL;
END
GO

--Super
CREATE PROCEDURE LOS_CRUD.MigrarSuper
AS
BEGIN
    INSERT INTO LOS_CRUD.Super (
        cuit_super, nombre_super, razon_soc_super, 
        iibb_super, domicilio_super, fecha_ini_actividad, 
        cond_fiscal, cod_localidad)
    SELECT DISTINCT 
        m.SUPER_CUIT, m.SUPER_NOMBRE, m.SUPER_RAZON_SOC, 
        m.SUPER_IIBB, m.SUPER_DOMICILIO, m.SUPER_FECHA_INI_ACTIVIDAD, 
        m.SUPER_CONDICION_FISCAL, l.cod_localidad
    FROM gd_esquema.Maestra m
    JOIN LOS_CRUD.Localidad l ON m.SUPER_LOCALIDAD = l.nombre_localidad
    WHERE m.SUPER_CUIT IS NOT NULL;
END;
GO


--Sucursal 
CREATE PROCEDURE LOS_CRUD.MigrarSucursal
AS
BEGIN
    INSERT INTO LOS_CRUD.Sucursal (nombre_sucursal, direccion_sucursal, cod_localidad)
    SELECT DISTINCT 
        m.SUCURSAL_NOMBRE, m.SUCURSAL_DIRECCION, l.cod_localidad
    FROM 
        gd_esquema.Maestra m
    JOIN 
        LOS_CRUD.Localidad l ON m.SUCURSAL_LOCALIDAD = l.nombre_localidad
    WHERE 
        m.SUCURSAL_NOMBRE IS NOT NULL;
END;
GO

--Cliente 
CREATE PROCEDURE LOS_CRUD.MigrarCliente
AS
BEGIN
    INSERT INTO LOS_CRUD.Cliente (nombre_cliente, apellido_cliente, dni_cliente, 
                                  fecha_registro_cliente, telefono_cliente, fecha_nacimiento_cliente, 
                                  domicilio_cliente, cod_localidad)
    SELECT DISTINCT 
        m.CLIENTE_NOMBRE, 
        m.CLIENTE_APELLIDO, 
        m.CLIENTE_DNI, 
        m.CLIENTE_FECHA_REGISTRO, 
        m.CLIENTE_TELEFONO, 
        m.CLIENTE_FECHA_NACIMIENTO, 
        m.CLIENTE_DOMICILIO, 
        l.cod_localidad
    FROM gd_esquema.Maestra m
    JOIN LOS_CRUD.Localidad l ON m.CLIENTE_LOCALIDAD = l.nombre_localidad
    JOIN LOS_CRUD.Provincia p ON l.cod_provincia = p.cod_provincia AND m.CLIENTE_PROVINCIA = p.nombre_provincia
    WHERE 
        m.CLIENTE_NOMBRE IS NOT NULL 
        AND m.CLIENTE_APELLIDO IS NOT NULL
        AND m.CLIENTE_DNI IS NOT NULL
END;
GO

--Empleado
CREATE PROCEDURE LOS_CRUD.MigrarEmpleado
AS
BEGIN
    INSERT INTO LOS_CRUD.Empleado (nombre_empleado, apellido_empleado, dni_empleado, 
                                   telefono_empleado, fecha_nacimiento_empleado, mail_empleado, 
                                   fecha_registro_empleado, cod_sucursal)
    SELECT DISTINCT 
        EMPLEADO_NOMBRE, EMPLEADO_APELLIDO, EMPLEADO_DNI,
        EMPLEADO_TELEFONO, EMPLEADO_FECHA_NACIMIENTO, EMPLEADO_MAIL,
        EMPLEADO_FECHA_REGISTRO, s.cod_sucursal
    FROM gd_esquema.Maestra m
    JOIN LOS_CRUD.Sucursal s ON m.SUCURSAL_NOMBRE = s.nombre_sucursal
    WHERE 
        EMPLEADO_DNI IS NOT NULL;
END;
GO


--Tipocaja
CREATE PROCEDURE LOS_CRUD.MigrarTipoCaja
AS
BEGIN
    INSERT INTO LOS_CRUD.TipoCaja (tipo_caja)
    SELECT DISTINCT CAJA_TIPO
    FROM gd_esquema.Maestra
    WHERE CAJA_TIPO IS NOT NULL;
END;
GO

--Caja
CREATE PROCEDURE LOS_CRUD.MigrarCaja
AS
BEGIN
    INSERT INTO LOS_CRUD.Caja (nro_caja, cod_sucursal, cod_tipo_caja)
    SELECT DISTINCT 
        CAJA_NUMERO, s.cod_sucursal, tc.cod_tipo_caja
    FROM gd_esquema.Maestra m
    JOIN LOS_CRUD.Sucursal s ON m.SUCURSAL_NOMBRE = s.nombre_sucursal
    JOIN LOS_CRUD.TipoCaja tc ON m.CAJA_TIPO = tc.tipo_caja
    WHERE 
        CAJA_NUMERO IS NOT NULL;
END;
GO

--Medio pago
CREATE PROCEDURE LOS_CRUD.MigrarMedioPago
AS
BEGIN
    INSERT INTO LOS_CRUD.MedioPago (descripcion_medio_pago)
    SELECT DISTINCT PAGO_MEDIO_PAGO
    FROM gd_esquema.Maestra
    WHERE PAGO_MEDIO_PAGO IS NOT NULL;
END
GO

-- Marca
CREATE PROCEDURE LOS_CRUD.MigrarMarca
AS
BEGIN
    INSERT INTO LOS_CRUD.Marca (nombre_marca)
    SELECT DISTINCT PRODUCTO_MARCA
    FROM gd_esquema.Maestra
    WHERE PRODUCTO_MARCA IS NOT NULL;
END
GO
--Categoria
CREATE PROCEDURE LOS_CRUD.MigrarCategoria
AS
BEGIN
    INSERT INTO LOS_CRUD.Categoria (nombre_categoria)
    SELECT DISTINCT PRODUCTO_CATEGORIA
    FROM gd_esquema.Maestra
    WHERE PRODUCTO_CATEGORIA IS NOT NULL;
END
GO
--Subcategoria
CREATE PROCEDURE LOS_CRUD.MigrarSubCategoria
AS
BEGIN
    INSERT INTO LOS_CRUD.SubCategoria (nombre_subcategoria, cod_categoria)
    SELECT DISTINCT 
        PRODUCTO_SUB_CATEGORIA, 
        c.cod_categoria
    FROM gd_esquema.Maestra m
    JOIN LOS_CRUD.Categoria c ON m.PRODUCTO_CATEGORIA = c.nombre_categoria
    WHERE PRODUCTO_SUB_CATEGORIA IS NOT NULL;
END
GO

-- Producto
CREATE PROCEDURE LOS_CRUD.MigrarProductos
AS
BEGIN
    INSERT INTO LOS_CRUD.Producto (nombre_prod, descripcion_prod, precio_prod, cod_subcategoria, cod_marca)
    SELECT DISTINCT 
        gm.PRODUCTO_NOMBRE, 
        gm.PRODUCTO_DESCRIPCION, 
        gm.PRODUCTO_PRECIO, 
        sc.cod_subcategoria,
        m.cod_marca
    FROM gd_esquema.Maestra gm
    JOIN LOS_CRUD.SubCategoria sc ON gm.PRODUCTO_SUB_CATEGORIA = sc.nombre_subcategoria
    JOIN LOS_CRUD.Categoria c ON gm.PRODUCTO_CATEGORIA = c.nombre_categoria
    JOIN LOS_CRUD.Marca m ON gm.PRODUCTO_MARCA = m.nombre_marca
    WHERE 
        gm.PRODUCTO_NOMBRE IS NOT NULL AND 
        gm.PRODUCTO_DESCRIPCION IS NOT NULL AND 
        gm.PRODUCTO_PRECIO IS NOT NULL AND 
        gm.PRODUCTO_SUB_CATEGORIA IS NOT NULL AND 
        gm.PRODUCTO_MARCA IS NOT NULL AND
        sc.cod_subcategoria IS NOT NULL AND
        c.cod_categoria IS NOT NULL AND
        m.cod_marca IS NOT NULL AND
        sc.cod_categoria = c.cod_categoria; -- Comparación entre la categoría de la subcategoría y la categoría de la tabla maestra
END
GO



--Tipo Comprobante
CREATE PROCEDURE LOS_CRUD.MigrarTipoDeComprobante
AS
BEGIN
    INSERT INTO LOS_CRUD.TipoDeComprobante (tipo_comprobante)
    SELECT DISTINCT TICKET_TIPO_COMPROBANTE
    FROM gd_esquema.Maestra
    WHERE TICKET_TIPO_COMPROBANTE IS NOT NULL;
END
GO



--Ticket
CREATE PROCEDURE LOS_CRUD.MigrarTickets
AS
BEGIN
    INSERT INTO LOS_CRUD.Ticket (cod_ticket_old, cod_cliente, fecha_hora_ticket, total_descuento_aplicado, total_descuento_aplicado_mp, 
                                total_ticket, cod_tipo_comprobante, cod_caja, cod_empleado)
    SELECT 
        gm.TICKET_NUMERO,
        MAX(cli.cod_cliente) AS cod_cliente,
        MAX(gm.TICKET_FECHA_HORA) AS TICKET_FECHA_HORA,
        MAX(gm.TICKET_TOTAL_DESCUENTO_APLICADO) AS TICKET_TOTAL_DESCUENTO_APLICADO,
        MAX(gm.TICKET_TOTAL_DESCUENTO_APLICADO_MP) AS TICKET_TOTAL_DESCUENTO_APLICADO_MP,
        MAX(gm.TICKET_TOTAL_TICKET) AS TICKET_TOTAL_TICKET,
        MAX(tc.cod_tipo_comprobante) AS cod_tipo_comprobante,
        MAX(c.nro_caja) AS nro_caja,
        MAX(e.legajo_empleado) AS legajo_empleado
    FROM gd_esquema.Maestra gm
    JOIN LOS_CRUD.TipoDeComprobante tc ON gm.TICKET_TIPO_COMPROBANTE = tc.tipo_comprobante
    LEFT JOIN LOS_CRUD.Caja c ON gm.CAJA_NUMERO = c.nro_caja
    LEFT JOIN LOS_CRUD.Empleado e ON gm.EMPLEADO_DNI = e.dni_empleado
    LEFT JOIN LOS_CRUD.CLIENTE cli ON gm.CLIENTE_DNI = cli.dni_cliente
    WHERE TICKET_FECHA_HORA IS NOT NULL
    GROUP BY gm.TICKET_NUMERO
    ORDER BY TICKET_NUMERO;

END
GO

--Envio 
CREATE PROCEDURE LOS_CRUD.MigrarEnvio
AS
BEGIN
    INSERT INTO LOS_CRUD.Envio (cod_ticket, costo_envio, fecha_programada_envio, 
                                hora_inicio_envio, hora_fin_envio, fecha_entrega_envio, estado_envio)
    SELECT DISTINCT 
        t.cod_ticket, 
        gm.ENVIO_COSTO, 
        gm.ENVIO_FECHA_PROGRAMADA, 
        gm.ENVIO_HORA_INICIO, 
        gm.ENVIO_HORA_FIN, 
        gm.ENVIO_FECHA_ENTREGA, 
        gm.ENVIO_ESTADO
    FROM gd_esquema.Maestra gm
    JOIN LOS_CRUD.Ticket t ON gm.TICKET_NUMERO = t.cod_ticket_old
    WHERE  ENVIO_COSTO IS NOT NULL;
END
GO

-- Pago
CREATE PROCEDURE LOS_CRUD.MigrarPago
AS
BEGIN
    INSERT INTO LOS_CRUD.Pago (fecha_pago, importe_pago, cod_ticket, cod_cliente, monto_descontado, cod_medio_pago, nro_tarjeta)
     SELECT 
        m.PAGO_FECHA,
        m.PAGO_IMPORTE,
        t.cod_ticket,
        m.PAGO_DESCUENTO_APLICADO,
        mp.cod_medio_pago,
        m.PAGO_TARJETA_NRO
    FROM 
        gd_esquema.Maestra m
    JOIN 
        LOS_CRUD.Ticket t ON m.TICKET_NUMERO = t.cod_ticket_old
    JOIN 
        LOS_CRUD.MedioPago mp ON mp.descripcion_medio_pago = m.PAGO_MEDIO_PAGO
    WHERE 
        m.PAGO_FECHA IS NOT NULL
END
GO

--Promocion
CREATE PROCEDURE LOS_CRUD.MigrarPromocion
AS
BEGIN
    INSERT INTO LOS_CRUD.Promocion (descripcion_promocion, fecha_inicio, fecha_fin)
    SELECT DISTINCT 
        gm.PROMOCION_DESCRIPCION, 
        gm.PROMOCION_FECHA_INICIO, 
        gm.PROMOCION_FECHA_FIN
    FROM gd_esquema.Maestra gm
    WHERE PROMOCION_DESCRIPCION IS NOT NULL;
END
GO

-- Promocion producto
CREATE PROCEDURE LOS_CRUD.MigrarPromocionProducto
AS
BEGIN
    INSERT INTO LOS_CRUD.PromocionProducto (cod_promocion, cod_producto)
    SELECT DISTINCT 
        p.cod_promocion, 
        pr.cod_producto
    FROM  gd_esquema.Maestra gm
    JOIN LOS_CRUD.Promocion p ON gm.PROMO_CODIGO = p.cod_promocion
    JOIN LOS_CRUD.Producto pr ON gm.PRODUCTO_NOMBRE = pr.nombre_prod
    WHERE PROMO_CODIGO IS NOT NULL;
END
GO

--Promocion Aplicada
CREATE PROCEDURE LOS_CRUD.MigrarPromocionAplicada
AS
BEGIN
    INSERT INTO LOS_CRUD.PromocionAplicada (cod_ticket, cod_promocion)
    SELECT DISTINCT 
        t.cod_ticket, 
        p.cod_promocion
    FROM gd_esquema.Maestra gm
    JOIN LOS_CRUD.Ticket t ON gm.TICKET_NUMERO = t.cod_ticket_old
    JOIN LOS_CRUD.Promocion p ON gm.PROMO_CODIGO = p.cod_promocion
    WHERE PROMO_CODIGO IS NOT NULL;
END
GO

--Ticket detalle
CREATE PROCEDURE LOS_CRUD.MigrarTicketDetalle
AS
BEGIN
    INSERT INTO LOS_CRUD.TicketDetalle (cod_ticket, cod_producto, cantidad, precio_unitario, precio_total)
    SELECT DISTINCT 
        t.cod_ticket, 
        p.cod_producto, 
        gm.TICKET_DET_CANTIDAD, 
        gm.TICKET_DET_PRECIO, 
        gm.TICKET_DET_TOTAL
    FROM gd_esquema.Maestra gm
    JOIN LOS_CRUD.Ticket t ON gm.TICKET_NUMERO = t.cod_ticket_old
    JOIN LOS_CRUD.Producto p ON gm.PRODUCTO_NOMBRE = p.nombre_prod
    WHERE TICKET_DETALLE_CANTIDAD IS NOT NULL;
END
GO

--Reglas
CREATE PROCEDURE LOS_CRUD.MigrarReglas
AS
BEGIN
    INSERT INTO LOS_CRUD.Reglas (descripcion_regla)
    SELECT DISTINCT 
        REGLA_DESCRIPCION
    FROM gd_esquema.Maestra
    WHERE REGLA_DESCRIPCION IS NOT NULL;
END
GO

--Promocion regla
CREATE PROCEDURE LOS_CRUD.MigrarPromocionReglas
AS
BEGIN
    INSERT INTO LOS_CRUD.PromocionReglas (cod_promocion, cod_regla)
    SELECT DISTINCT 
        p.cod_promocion, 
        r.cod_regla
    FROM 
        gd_esquema.Maestra gm
    JOIN 
        LOS_CRUD.Promocion p ON gm.PROMO_CODIGO = p.cod_promocion
    JOIN 
        LOS_CRUD.Reglas r ON gm.REGLA_DESCRIPCION = r.descripcion_regla
    WHERE 
        PROMO_CODIGO IS NOT NULL;
END
GO

--Descuento
CREATE PROCEDURE LOS_CRUD.MigrarDescuento
AS
BEGIN
    INSERT INTO LOS_CRUD.Descuento (descripcion_descuento, porcentaje_descuento)
    SELECT DISTINCT 
        DESCUENTO_DESCRIPCION, 
        DESCUENTO_PORCENTAJE
    FROM 
        gd_esquema.Maestra
    WHERE 
        DESCUENTO_DESCRIPCION IS NOT NULL AND DESCUENTO_PORCENTAJE IS NOT NULL;
END
GO





-- Creacion de tablas --

-- Crear tabla Provincia
CREATE TABLE LOS_CRUD.Provincia (
    cod_provincia INT IDENTITY(1,1) PRIMARY KEY,
    nombre_provincia VARCHAR(255) NOT NULL
);

-- Crear tabla Localidad
CREATE TABLE LOS_CRUD.Localidad (
    cod_localidad INT IDENTITY(1,1) PRIMARY KEY,
    nombre_localidad VARCHAR(255) NOT NULL,
    cod_provincia INT,
    FOREIGN KEY (cod_provincia) REFERENCES LOS_CRUD.Provincia(cod_provincia)
);

-- Crear tabla Sucursal
CREATE TABLE LOS_CRUD.Sucursal (
    cod_sucursal INT IDENTITY(1,1) PRIMARY KEY,
    nombre_sucursal VARCHAR(255) NOT NULL,
    direccion_sucursal VARCHAR(255) NOT NULL,
    cod_localidad INT,
    FOREIGN KEY (cod_Localidad) REFERENCES LOS_CRUD.Localidad(cod_localidad)
);

-- Crear tabla Cliente
CREATE TABLE LOS_CRUD.Cliente (
    cod_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombre_cliente VARCHAR(255) NOT NULL,
    apellido_cliente VARCHAR(255) NOT NULL,
    dni_cliente DECIMAL(18,0) NOT NULL,
    fecha_registro_cliente DATE,
    telefono_cliente DECIMAL(18,0),
    fecha_nacimiento_cliente DATE,
    domicilio_cliente VARCHAR(255),
    cod_localidad INT,
    FOREIGN KEY (cod_Localidad) REFERENCES LOS_CRUD.Localidad(cod_localidad)
);

-- Crear tabla TipoCaja
CREATE TABLE LOS_CRUD.TipoCaja (
    cod_tipo_caja INT IDENTITY(1,1) PRIMARY KEY,
    tipo_caja VARCHAR(255) NOT NULL
);

-- Crear tabla Caja
CREATE TABLE LOS_CRUD.Caja (
    nro_caja INT IDENTITY(1,1) PRIMARY KEY,
    cod_sucursal INT,
    cod_tipo_caja INT,
    FOREIGN KEY (cod_sucursal) REFERENCES LOS_CRUD.Sucursal(cod_sucursal),
    FOREIGN KEY (cod_tipo_caja) REFERENCES LOS_CRUD.TipoCaja(cod_tipo_caja)
);

-- Crear tabla MedioPago
CREATE TABLE LOS_CRUD.MedioPago (
    cod_medio_pago INT IDENTITY(1,1) PRIMARY KEY,
    descripcion_medio_pago VARCHAR(255) NOT NULL
);

-- Crear tabla Marca
CREATE TABLE LOS_CRUD.Marca (
    cod_marca INT IDENTITY(1,1) PRIMARY KEY,
    nombre_marca VARCHAR(255) NOT NULL
);

-- Crear tabla Categoria
CREATE TABLE LOS_CRUD.Categoria (
    cod_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria VARCHAR(255) NOT NULL
);

-- Crear tabla SubCategoria
CREATE TABLE LOS_CRUD.SubCategoria (
    cod_subcategoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre_subcategoria VARCHAR(255) NOT NULL,
    cod_categoria INT,
    FOREIGN KEY (cod_categoria) REFERENCES LOS_CRUD.Categoria(cod_categoria)
);

-- Crear tabla Producto
CREATE TABLE LOS_CRUD.Producto (
    cod_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre_prod VARCHAR(255) NOT NULL,
    descripcion_prod VARCHAR(255),
    precio_prod DECIMAL(10, 2) NOT NULL,
    cod_subcategoria INT,
    cod_marca INT,
    FOREIGN KEY (cod_subcategoria) REFERENCES LOS_CRUD.SubCategoria(cod_subcategoria),
    FOREIGN KEY (cod_marca) REFERENCES LOS_CRUD.Marca(cod_marca)
);

-- Crear tabla TipoDeComprobante
CREATE TABLE LOS_CRUD.TipoDeComprobante (
    cod_tipo_comprobante INT IDENTITY(1,1) PRIMARY KEY,
    tipo_comprobante VARCHAR(255) NOT NULL
);

-- Crear tabla Empleado
CREATE TABLE LOS_CRUD.Empleado (
    legajo_empleado INT IDENTITY(1,1) PRIMARY KEY,
    cod_sucursal INT,
    nombre_empleado VARCHAR(255) NOT NULL,
    apellido_empleado VARCHAR(255) NOT NULL,
    dni_empleado DECIMAL(18,0)  NOT NULL,
    telefono_empleado DECIMAL(18,0) ,
    fecha_nacimiento_empleado DATE,
    mail_empleado VARCHAR(255),
    fecha_registro_empleado DATE,
    FOREIGN KEY (cod_sucursal) REFERENCES LOS_CRUD.Sucursal(cod_sucursal)
);


-- Crear tabla Ticket
CREATE TABLE LOS_CRUD.Ticket (
    cod_ticket INT IDENTITY(1,1) PRIMARY KEY,
    cod_ticket_old DECIMAL(18,0),
    cod_cliente INT NULL,
    fecha_hora_ticket DATETIME NOT NULL,
    total_descuento_aplicado DECIMAL(10, 2),
    total_descuento_aplicado_mp DECIMAL(10, 2),
    total_ticket DECIMAL(10, 2) NOT NULL,
    cod_tipo_comprobante INT,
    cod_caja INT,
    cod_empleado INT,
    FOREIGN KEY (cod_tipo_comprobante) REFERENCES LOS_CRUD.TipoDeComprobante(cod_tipo_comprobante),
    FOREIGN KEY (cod_empleado) REFERENCES LOS_CRUD.Empleado(legajo_empleado),
    FOREIGN KEY (cod_caja) REFERENCES LOS_CRUD.Caja(cod_caja),
    FOREIGN KEY (cod_cliente) REFERENCES LOS_CRUD.Cliente
);

-- Crear tabla Envio
CREATE TABLE LOS_CRUD.Envio (
    cod_envio INT IDENTITY(1,1)PRIMARY KEY,
    cod_ticket INT,
    costo_envio DECIMAL(10, 2),
    fecha_programada_envio DATE,
    hora_inicio_envio TIME,
    hora_fin_envio TIME,
    fecha_entrega_envio DATETIME,
    estado_envio VARCHAR(255),
    FOREIGN KEY (cod_ticket) REFERENCES LOS_CRUD.Ticket(cod_ticket)
);


-- Crear tabla Pago
CREATE TABLE LOS_CRUD.Pago (
    cod_pago INT IDENTITY(1,1) PRIMARY KEY,
    fecha_pago DATETIME NOT NULL,
    importe_pago DECIMAL(10, 2) NOT NULL,
    cod_ticket INT,
    monto_descontado DECIMAL(10, 2),
    cod_medio_pago INT,
    nro_tarjeta VARCHAR(50),
    FOREIGN KEY (cod_ticket) REFERENCES LOS_CRUD.Ticket(cod_ticket),
    FOREIGN KEY (cod_medio_pago) REFERENCES LOS_CRUD.MedioPago(cod_medio_pago),
);

--Crear tabla Detalle Pago
CREATE TABLE LOS_CRUD.DetallePago (
    cod_detalle_pago INT IDENTITY(1,1) PRIMARY KEY,
    nro_tarjeta INT ,
    cod_pago INT,
    cod_cliente INT,
    cuotas_tarjeta INT,
    fecha_venc_tarjeta DATETIME,
    FOREIGN KEY (cod_cliente) REFERENCES LOS_CRUD.Cliente(cod_cliente),
    FOREIGN KEY (cod_pago) REFERENCES LOS_CRUD.Pago(cod_pago),
    );

-- Crear tabla Promocion
CREATE TABLE LOS_CRUD.Promocion (
    cod_promocion INT IDENTITY(1,1) PRIMARY KEY,
    descripcion_promocion VARCHAR(255) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

-- Crear tabla PromocionProducto
CREATE TABLE LOS_CRUD.PromocionProducto (
    cod_promocion INT,
    cod_producto INT,
    PRIMARY KEY (cod_promocion, cod_producto),
    FOREIGN KEY (cod_promocion) REFERENCES LOS_CRUD.Promocion(cod_promocion),
    FOREIGN KEY (cod_producto) REFERENCES LOS_CRUD.Producto(cod_producto)
);

-- Crear tabla PromocionAplicada
CREATE TABLE LOS_CRUD.PromocionAplicada (
    cod_promocion_aplicada INT IDENTITY(1,1) PRIMARY KEY,
    cod_ticket INT,
    cod_producto INT,
    cod_promocion INT,
    descuento_aplicado DECIMAL(10, 2),
    FOREIGN KEY (cod_ticket) REFERENCES LOS_CRUD.Ticket(cod_ticket),
    FOREIGN KEY (cod_producto) REFERENCES LOS_CRUD.Producto(cod_producto),
    FOREIGN KEY (cod_promocion) REFERENCES LOS_CRUD.Promocion(cod_promocion)
);

-- Crear tabla Descuento
CREATE TABLE LOS_CRUD.Descuento (
    cod_descuento INT IDENTITY(1,1) PRIMARY KEY,
    descripcion_descuento VARCHAR(255) NOT NULL,
    fecha_inicio_descuento DATE NOT NULL,
    fecha_fin_descuento DATE NOT NULL,
    porcentaje_descuento DECIMAL(5, 2) NOT NULL,
    cod_medio_pago INT FOREIGN KEY references LOS_CRUD.MedioPago,
    tope_descuento DECIMAL(10, 2)
);


-- Crear tabla TicketDetalle
CREATE TABLE LOS_CRUD.TicketDetalle (
    cod_ticket INT,
    cod_producto INT,
    cantcodad DECIMAL(10, 2),
    total DECIMAL(10, 2),
    PRIMARY KEY (cod_ticket, cod_producto),
    FOREIGN KEY (cod_ticket) REFERENCES LOS_CRUD.Ticket(cod_ticket),
    FOREIGN KEY (cod_producto) REFERENCES LOS_CRUD.Producto(cod_producto)
);

-- Crear tabla Super
CREATE TABLE LOS_CRUD.Super (
    cod_super INT IDENTITY(1,1) PRIMARY KEY,
    cuit_super NVARCHAR(255),
    nombre_super NVARCHAR(255),
    razon_soc_super NVARCHAR(255),
    iibb_super NVARCHAR(255),
    domicilio_super NVARCHAR(255),
    fecha_ini_actividad DATETIME,
    cod_localidad INT,
    cond_fiscal NVARCHAR(255),
    FOREIGN KEY (cod_Localidad) REFERENCES LOS_CRUD.Localidad(cod_Localidad)
);

-- Crear tabla Reglas
CREATE TABLE LOS_CRUD.Reglas (
    cod_regla INT IDENTITY(1,1) PRIMARY KEY,
    cod_promocion INT,
    aplica_misma_marca INT,
    aplica_mismo_prod INT,
    cant_aplica_descuento INT,
    cant_aplicable_regla INT,
    descripcion_regla VARCHAR(255),
    descuento_aplicable_regla DECIMAL(5, 2),
    cantcodad_max_prod INT,
    FOREIGN KEY (cod_promocion) REFERENCES LOS_CRUD.Promocion(cod_promocion)
);

-- Crear tabla PromocionReglas
CREATE TABLE LOS_CRUD.PromocionReglas (
    cod_promocion INT,
    cod_regla INT,
    PRIMARY KEY (cod_promocion, cod_regla),
    FOREIGN KEY (cod_promocion) REFERENCES LOS_CRUD.Promocion(cod_promocion),
    FOREIGN KEY (cod_regla) REFERENCES LOS_CRUD.Reglas(cod_regla)
);


-- CREACION DE INDICES 


-- Ejecucion de los Stored Procedures
CREATE PROCEDURE LOS_CRUD.MigrarDatos
AS
BEGIN
    -- Llamar a los procedimientos específicos en orden de dependencia
    EXEC LOS_CRUD.MigrarProvincias;
    EXEC LOS_CRUD.MigrarLocalidades;
    EXEC LOS_CRUD.MigrarSuper;
    EXEC LOS_CRUD.MigrarSucursal;
    EXEC LOS_CRUD.MigrarCliente;
    EXEC LOS_CRUD.MigrarEmpleado;
    EXEC LOS_CRUD.MigrarTipoCaja;
    EXEC LOS_CRUD.MigrarCaja;
    EXEC LOS_CRUD.MigrarTipoDeComprobante;
    EXEC LOS_CRUD.MigrarMarca;
    EXEC LOS_CRUD.MigrarCategoria;
    EXEC LOS_CRUD.MigrarSubCategoria;
    EXEC LOS_CRUD.MigrarProducto;
    EXEC LOS_CRUD.MigrarPromocion;
    EXEC LOS_CRUD.MigrarReglas;
    EXEC LOS_CRUD.MigrarPromocionReglas;
    EXEC LOS_CRUD.MigrarMedioPago;
    EXEC LOS_CRUD.MigrarDescuento;
    EXEC LOS_CRUD.MigrarTicket;
    EXEC LOS_CRUD.MigrarTicketDetalle;
    EXEC LOS_CRUD.MigrarPromocionAplicada;
    EXEC LOS_CRUD.MigrarPago;
    EXEC LOS_CRUD.MigrarEnvio;
    PRINT 'Migracion finalizada exitosamente'
END;
GO

EXECUTE LOS_CRUD.MigrarDatos

GO 
