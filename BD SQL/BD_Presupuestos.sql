USE [Edu_Presupuestos]
GO
/****** Object:  User [edu]    Script Date: 16/12/2021 11:24:36 a. m. ******/
CREATE USER [edu] FOR LOGIN [edu] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [edu]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 16/12/2021 11:24:36 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[TipoOperacionId] [int] NOT NULL,
	[UsuarioId] [int] NOT NULL,
 CONSTRAINT [PK_Categorias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cuentas]    Script Date: 16/12/2021 11:24:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cuentas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[TipoCuentaId] [int] NOT NULL,
	[Balance] [decimal](18, 2) NOT NULL,
	[Descripcion] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Cuentas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposCuentas]    Script Date: 16/12/2021 11:24:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposCuentas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[Orden] [int] NOT NULL,
 CONSTRAINT [PK_TiposCuentas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposOperaciones]    Script Date: 16/12/2021 11:24:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposOperaciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TiposOperaciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transacciones]    Script Date: 16/12/2021 11:24:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transacciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[FechaTransaccion] [datetime] NOT NULL,
	[Monto] [decimal](18, 2) NOT NULL,
	[TipoOperacionId] [int] NOT NULL,
	[Nota] [nvarchar](1000) NULL,
	[CuentaId] [int] NOT NULL,
	[CategoriaId] [int] NOT NULL,
 CONSTRAINT [PK_Transacciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 16/12/2021 11:24:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[EmailNormalizado] [nvarchar](256) NOT NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TiposOperaciones] ON 

INSERT [dbo].[TiposOperaciones] ([Id], [Descripcion]) VALUES (1, N'Ingresos')
INSERT [dbo].[TiposOperaciones] ([Id], [Descripcion]) VALUES (2, N'Gastos')
SET IDENTITY_INSERT [dbo].[TiposOperaciones] OFF
GO
ALTER TABLE [dbo].[Categorias]  WITH CHECK ADD  CONSTRAINT [FK_Categorias_TiposOperaciones] FOREIGN KEY([Id])
REFERENCES [dbo].[TiposOperaciones] ([Id])
GO
ALTER TABLE [dbo].[Categorias] CHECK CONSTRAINT [FK_Categorias_TiposOperaciones]
GO
ALTER TABLE [dbo].[Categorias]  WITH CHECK ADD  CONSTRAINT [FK_Categorias_Usuarios] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Categorias] CHECK CONSTRAINT [FK_Categorias_Usuarios]
GO
ALTER TABLE [dbo].[Cuentas]  WITH CHECK ADD  CONSTRAINT [FK_Cuentas_TiposCuentas] FOREIGN KEY([TipoCuentaId])
REFERENCES [dbo].[TiposCuentas] ([Id])
GO
ALTER TABLE [dbo].[Cuentas] CHECK CONSTRAINT [FK_Cuentas_TiposCuentas]
GO
ALTER TABLE [dbo].[TiposCuentas]  WITH CHECK ADD  CONSTRAINT [FK_TiposCuentas_Usuarios] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[TiposCuentas] CHECK CONSTRAINT [FK_TiposCuentas_Usuarios]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_Categorias] FOREIGN KEY([CategoriaId])
REFERENCES [dbo].[Categorias] ([Id])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_Categorias]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_TiposCuentas] FOREIGN KEY([CuentaId])
REFERENCES [dbo].[TiposCuentas] ([Id])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_TiposCuentas]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_TiposOperaciones] FOREIGN KEY([TipoOperacionId])
REFERENCES [dbo].[TiposOperaciones] ([Id])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_TiposOperaciones]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_Usuarios] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_Usuarios]
GO
