

/* ============================================================
   LEGADOSEGURO - SCRIPT DE BASE DE DATOS (SQL SERVER)
   Basado en el MER de 24 entidades (Anexo B del informe)
   ============================================================ */

CREATE DATABASE LegadoSeguroDB;
GO
USE LegadoSeguroDB;
GO

/* ============================================================
   1. CREACIÓN DE TABLAS
   ============================================================ */

-- Usuarios y seguridad -----------------------------------------------------

CREATE TABLE ROL (
    id_rol      INT IDENTITY(1,1) PRIMARY KEY,
    nombre      NVARCHAR(50)  NOT NULL,
    descripcion NVARCHAR(200) NULL,
    estado      NVARCHAR(20)  NOT NULL DEFAULT 'ACTIVO'
);

CREATE TABLE USUARIO (
    id_usuario      INT IDENTITY(1,1) PRIMARY KEY,
    id_rol          INT NOT NULL,
    nombres         NVARCHAR(100) NOT NULL,
    apellidos       NVARCHAR(100) NOT NULL,
    dni             NVARCHAR(15)  NOT NULL,
    correo          NVARCHAR(150) NOT NULL UNIQUE,
    password_hash   NVARCHAR(255) NOT NULL,
    telefono        NVARCHAR(20)  NULL,
    fecha_registro  DATETIME2     NOT NULL DEFAULT SYSDATETIME(),
    estado          NVARCHAR(20)  NOT NULL DEFAULT 'ACTIVO',
    CONSTRAINT FK_USUARIO_ROL FOREIGN KEY (id_rol) REFERENCES ROL(id_rol)
);

CREATE TABLE TOKEN_RECUPERACION (
    id_token          INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario        INT NOT NULL,
    token_hash        NVARCHAR(255) NOT NULL,
    fecha_generacion  DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    fecha_expiracion  DATETIME2 NOT NULL,
    usado             BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_TOKEN_USUARIO FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

-- Activos y beneficiarios ---------------------------------------------------

CREATE TABLE TIPO_ACTIVO (
    id_tipo                INT IDENTITY(1,1) PRIMARY KEY,
    nombre                 NVARCHAR(80) NOT NULL,
    categoria_sensibilidad NVARCHAR(20) NOT NULL  -- 'BAJA' | 'FINANCIERA'
);

CREATE TABLE ACTIVO_DIGITAL (
    id_activo            INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario           INT NOT NULL,
    id_tipo              INT NOT NULL,
    nombre               NVARCHAR(150) NOT NULL,
    descripcion          NVARCHAR(300) NULL,
    ubicacion_referencia NVARCHAR(200) NULL,
    estado               NVARCHAR(20)  NOT NULL DEFAULT 'ACTIVO',
    fecha_registro       DATETIME2     NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT FK_ACTIVO_USUARIO FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    CONSTRAINT FK_ACTIVO_TIPO    FOREIGN KEY (id_tipo)    REFERENCES TIPO_ACTIVO(id_tipo)
);

CREATE TABLE BENEFICIARIO (
    id_beneficiario       INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario_propietario INT NOT NULL,
    nombres               NVARCHAR(100) NOT NULL,
    apellidos             NVARCHAR(100) NOT NULL,
    dni                   NVARCHAR(15)  NOT NULL,
    correo                NVARCHAR(150) NOT NULL,
    telefono              NVARCHAR(20)  NULL,
    parentesco            NVARCHAR(50)  NULL,
    clave_acceso_hash     NVARCHAR(255) NOT NULL,
    estado                NVARCHAR(20)  NOT NULL DEFAULT 'ACTIVO',
    CONSTRAINT FK_BENEFICIARIO_USUARIO FOREIGN KEY (id_usuario_propietario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE ACTIVO_BENEFICIARIO (
    id_activo      INT NOT NULL,
    id_beneficiario INT NOT NULL,
    prioridad      INT NOT NULL DEFAULT 1,
    estado         NVARCHAR(20) NOT NULL DEFAULT 'ACTIVO',
    CONSTRAINT PK_ACTIVO_BENEFICIARIO PRIMARY KEY (id_activo, id_beneficiario),
    CONSTRAINT FK_AB_ACTIVO      FOREIGN KEY (id_activo)      REFERENCES ACTIVO_DIGITAL(id_activo),
    CONSTRAINT FK_AB_BENEFICIARIO FOREIGN KEY (id_beneficiario) REFERENCES BENEFICIARIO(id_beneficiario)
);

CREATE TABLE VALIDADOR_EXTERNO (
    id_validador           INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario_propietario INT NOT NULL,
    nombres                NVARCHAR(100) NOT NULL,
    correo                 NVARCHAR(150) NOT NULL,
    telefono               NVARCHAR(20)  NULL,
    estado                 NVARCHAR(20)  NOT NULL DEFAULT 'ACTIVO',
    CONSTRAINT FK_VALIDADOR_USUARIO FOREIGN KEY (id_usuario_propietario) REFERENCES USUARIO(id_usuario)
);

-- Reglas y monitoreo ---------------------------------------------------------

CREATE TABLE REGLA_LIBERACION (
    id_regla            INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario          INT NOT NULL,
    dias_inactividad    INT NOT NULL,
    min_confirmaciones  INT NOT NULL DEFAULT 1,
    dias_periodo_espera INT NOT NULL,
    requiere_validador  BIT NOT NULL DEFAULT 0,
    estado              NVARCHAR(20) NOT NULL DEFAULT 'ACTIVA',
    CONSTRAINT FK_REGLA_USUARIO FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE ACTIVIDAD_USUARIO (
    id_actividad     INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario       INT NOT NULL,
    fecha_actividad  DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    tipo_evento      NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_ACTIVIDAD_USUARIO FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

-- Proceso de liberación -------------------------------------------------------

CREATE TABLE REPORTE_FALLECIMIENTO (
    id_reporte                 INT IDENTITY(1,1) PRIMARY KEY,
    id_beneficiario_reportante INT NOT NULL,
    id_usuario_revisor         INT NULL,
    fecha_reporte              DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    documentacion_adjunta      NVARCHAR(300) NULL,
    estado                     NVARCHAR(20)  NOT NULL DEFAULT 'PENDIENTE',
    fecha_revision             DATETIME2 NULL,
    CONSTRAINT FK_REPORTE_BENEFICIARIO FOREIGN KEY (id_beneficiario_reportante) REFERENCES BENEFICIARIO(id_beneficiario),
    CONSTRAINT FK_REPORTE_REVISOR      FOREIGN KEY (id_usuario_revisor)         REFERENCES USUARIO(id_usuario)
);

CREATE TABLE PROCESO_LIBERACION (
    id_proceso             INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario_propietario INT NOT NULL,
    id_regla               INT NOT NULL,
    id_reporte_origen      INT NULL,
    fecha_inicio           DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    fecha_fin              DATETIME2 NULL,
    estado                 NVARCHAR(30) NOT NULL DEFAULT 'DETECTADO',
    motivo                 NVARCHAR(200) NULL,
    CONSTRAINT FK_PROCESO_USUARIO FOREIGN KEY (id_usuario_propietario) REFERENCES USUARIO(id_usuario),
    CONSTRAINT FK_PROCESO_REGLA   FOREIGN KEY (id_regla)               REFERENCES REGLA_LIBERACION(id_regla),
    CONSTRAINT FK_PROCESO_REPORTE FOREIGN KEY (id_reporte_origen)      REFERENCES REPORTE_FALLECIMIENTO(id_reporte)
);

CREATE TABLE PROCESO_ACTIVO (
    id_proceso INT NOT NULL,
    id_activo  INT NOT NULL,
    estado     NVARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',
    CONSTRAINT PK_PROCESO_ACTIVO PRIMARY KEY (id_proceso, id_activo),
    CONSTRAINT FK_PA_PROCESO FOREIGN KEY (id_proceso) REFERENCES PROCESO_LIBERACION(id_proceso),
    CONSTRAINT FK_PA_ACTIVO  FOREIGN KEY (id_activo)  REFERENCES ACTIVO_DIGITAL(id_activo)
);

CREATE TABLE CONFIRMACION_BENEFICIARIO (
    id_confirmacion INT IDENTITY(1,1) PRIMARY KEY,
    id_proceso      INT NOT NULL,
    id_activo       INT NOT NULL,
    id_beneficiario INT NOT NULL,
    resultado       NVARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',
    fecha           DATETIME2 NULL,
    CONSTRAINT FK_CONF_PROCESO      FOREIGN KEY (id_proceso)      REFERENCES PROCESO_LIBERACION(id_proceso),
    CONSTRAINT FK_CONF_ACTIVO       FOREIGN KEY (id_activo)       REFERENCES ACTIVO_DIGITAL(id_activo),
    CONSTRAINT FK_CONF_BENEFICIARIO FOREIGN KEY (id_beneficiario) REFERENCES BENEFICIARIO(id_beneficiario)
);

CREATE TABLE VALIDACION_EXTERNA (
    id_validacion INT IDENTITY(1,1) PRIMARY KEY,
    id_proceso    INT NOT NULL,
    id_validador  INT NOT NULL,
    resultado     NVARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',
    fecha         DATETIME2 NULL,
    observacion   NVARCHAR(300) NULL,
    CONSTRAINT FK_VE_PROCESO   FOREIGN KEY (id_proceso)   REFERENCES PROCESO_LIBERACION(id_proceso),
    CONSTRAINT FK_VE_VALIDADOR FOREIGN KEY (id_validador) REFERENCES VALIDADOR_EXTERNO(id_validador)
);

CREATE TABLE OBJECION (
    id_objecion       INT IDENTITY(1,1) PRIMARY KEY,
    id_proceso        INT NOT NULL,
    id_beneficiario   INT NULL,
    id_usuario        INT NULL,
    motivo            NVARCHAR(300) NOT NULL,
    estado            NVARCHAR(20)  NOT NULL DEFAULT 'ABIERTA',
    fecha             DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    fecha_resolucion  DATETIME2 NULL,
    CONSTRAINT FK_OBJ_PROCESO      FOREIGN KEY (id_proceso)      REFERENCES PROCESO_LIBERACION(id_proceso),
    CONSTRAINT FK_OBJ_BENEFICIARIO FOREIGN KEY (id_beneficiario) REFERENCES BENEFICIARIO(id_beneficiario),
    CONSTRAINT FK_OBJ_USUARIO      FOREIGN KEY (id_usuario)      REFERENCES USUARIO(id_usuario)
);

CREATE TABLE ENTREGA (
    id_entrega          INT IDENTITY(1,1) PRIMARY KEY,
    id_proceso          INT NOT NULL,
    id_activo           INT NOT NULL,
    id_beneficiario     INT NOT NULL,
    token_acceso_hash   NVARCHAR(255) NOT NULL,
    estado              NVARCHAR(20) NOT NULL DEFAULT 'AUTORIZADA',
    fecha_autorizacion  DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    fecha_acceso        DATETIME2 NULL,
    CONSTRAINT FK_ENT_PROCESO      FOREIGN KEY (id_proceso)      REFERENCES PROCESO_LIBERACION(id_proceso),
    CONSTRAINT FK_ENT_ACTIVO       FOREIGN KEY (id_activo)       REFERENCES ACTIVO_DIGITAL(id_activo),
    CONSTRAINT FK_ENT_BENEFICIARIO FOREIGN KEY (id_beneficiario) REFERENCES BENEFICIARIO(id_beneficiario)
);

-- Orientación legal ------------------------------------------------------------

CREATE TABLE GUIA_LEGAL (
    id_guia             INT IDENTITY(1,1) PRIMARY KEY,
    tema                NVARCHAR(150) NOT NULL,
    contenido           NVARCHAR(MAX) NOT NULL,
    version             INT NOT NULL DEFAULT 1,
    fecha_actualizacion DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);

CREATE TABLE ORIENTACION_LEGAL_GENERADA (
    id_orientacion      INT IDENTITY(1,1) PRIMARY KEY,
    id_proceso          INT NOT NULL,
    id_activo           INT NOT NULL,
    id_guia             INT NOT NULL,
    entidad_referencial NVARCHAR(150) NULL,
    fecha_generacion    DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT FK_OLG_PROCESO FOREIGN KEY (id_proceso) REFERENCES PROCESO_LIBERACION(id_proceso),
    CONSTRAINT FK_OLG_ACTIVO  FOREIGN KEY (id_activo)  REFERENCES ACTIVO_DIGITAL(id_activo),
    CONSTRAINT FK_OLG_GUIA    FOREIGN KEY (id_guia)    REFERENCES GUIA_LEGAL(id_guia)
);

-- Notificaciones y auditoría -----------------------------------------------------

CREATE TABLE NOTIFICACION (
    id_notificacion              INT IDENTITY(1,1) PRIMARY KEY,
    id_proceso                   INT NULL,
    id_usuario_destinatario      INT NULL,
    id_beneficiario_destinatario INT NULL,
    canal                        NVARCHAR(20) NOT NULL,  -- 'CORREO' | 'SMS' | 'WHATSAPP'
    asunto                       NVARCHAR(150) NULL,
    mensaje                      NVARCHAR(500) NOT NULL,
    estado                       NVARCHAR(20) NOT NULL DEFAULT 'ENVIADA',
    fecha_envio                  DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT FK_NOTIF_PROCESO      FOREIGN KEY (id_proceso)                   REFERENCES PROCESO_LIBERACION(id_proceso),
    CONSTRAINT FK_NOTIF_USUARIO      FOREIGN KEY (id_usuario_destinatario)      REFERENCES USUARIO(id_usuario),
    CONSTRAINT FK_NOTIF_BENEFICIARIO FOREIGN KEY (id_beneficiario_destinatario) REFERENCES BENEFICIARIO(id_beneficiario)
);

CREATE TABLE AUDITORIA (
    id_auditoria INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario   INT NULL,
    fecha        DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    accion       NVARCHAR(100) NOT NULL,
    entidad      NVARCHAR(100) NULL,
    id_entidad   INT NULL,
    descripcion  NVARCHAR(300) NULL,
    CONSTRAINT FK_AUD_USUARIO FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

-- Suscripciones y pagos -----------------------------------------------------------

CREATE TABLE [PLAN] (
    id_plan     INT IDENTITY(1,1) PRIMARY KEY,
    nombre      NVARCHAR(50) NOT NULL,
    tipo        NVARCHAR(20) NOT NULL,  -- 'FREE' | 'PREMIUM'
    precio      DECIMAL(10,2) NOT NULL DEFAULT 0,
    descripcion NVARCHAR(300) NULL,
    estado      NVARCHAR(20) NOT NULL DEFAULT 'ACTIVO'
);

CREATE TABLE SUSCRIPCION (
    id_suscripcion INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario     INT NOT NULL,
    id_plan        INT NOT NULL,
    fecha_inicio   DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    fecha_fin      DATETIME2 NULL,
    estado         NVARCHAR(20) NOT NULL DEFAULT 'ACTIVA',
    CONSTRAINT FK_SUSC_USUARIO FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    CONSTRAINT FK_SUSC_PLAN    FOREIGN KEY (id_plan)    REFERENCES [PLAN](id_plan)
);

CREATE TABLE PAGO (
    id_pago                 INT IDENTITY(1,1) PRIMARY KEY,
    id_suscripcion          INT NOT NULL,
    monto                   DECIMAL(10,2) NOT NULL,
    fecha_pago              DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    estado                  NVARCHAR(20) NOT NULL DEFAULT 'COMPLETADO',
    referencia_pago_externa NVARCHAR(100) NULL,
    CONSTRAINT FK_PAGO_SUSCRIPCION FOREIGN KEY (id_suscripcion) REFERENCES SUSCRIPCION(id_suscripcion)
);
GO
