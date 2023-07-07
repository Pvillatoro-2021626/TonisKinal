/*
NOMBRE: Patrick Eduardo Villatoro Ic
CARNET: 2021626
CLASE: Taller II
CODIGO TECNICO: in5av
FECHA: 17-02-2022
*/
DROP DATABASE IF EXISTS DBTonisKinal2021626; 
CREATE DATABASE DBTonisKinal2021626; 

USE DBTonisKinal2021626; 

CREATE TABLE TipoEmpleado( 
	codigoTipoEmpleado int not null auto_increment, 
	descripcion varchar(100) not null,  
	primary key PK_codigoTipoEmpleado (codigoTipoEmpleado) 
); 

CREATE TABLE TipoPlato ( 
	codigoTipoPlato int not null auto_increment, 
	descripcionTipo varchar(100) not null,
	primary key PK_codigoTipoPlato (codigoTipoPlato)
); 

CREATE TABLE Productos( 
	codigoProducto int not null auto_increment, 
	nombreProducto varchar(150) not null, 
	cantidad int not null,
	primary key PK_codigoProducto (codigoProducto)
); 

CREATE TABLE Empresas( 
	codigoEmpresa int not null auto_increment, 
	nombreEmpresa varchar(150) not null, 
	direccion varchar(150) not null, 
	telefono varchar(10) not null,
	primary key PK_codigoEmpresa (codigoEmpresa)
); 

CREATE TABLE Presupuesto( 
	codigoPresupuesto int not null auto_increment, 
	fechaSolicitud date, 
	cantidadPresupuesto decimal(10,2), 
	codigoEmpresa int not null, 
	primary key PK_codigoPresupuesto (codigoPresupuesto), 
	constraint FK_Presupuesto_Empresas foreign key (codigoEmpresa) 
	references Empresas(codigoEmpresa) 
); 

CREATE TABLE Servicios( 
	codigoServicio int not null auto_increment, 
	fechaServicio date not null, 
	tipoServicio varchar(100) not null, 
	horaServicio time not null, 
	lugarServicio varchar(100) not null, 
	telefonoContacto varchar(10) not null, 
	codigoEmpresa int not null, 
	primary key codigoServicio (codigoServicio), 
	constraint FK_Servicio_Empresas foreign key(codigoEmpresa) 
	references Empresas(codigoEmpresa) 
); 

CREATE TABLE Platos(
	codigoPlato int not null auto_increment,
	cantidad int not null,
	nombrePlato varchar(50) not null,
	descripcionPlato varchar(150) not null,
	precioPlato decimal(10,2) not null, 
	codigoTipoPlato int not null,
	primary key PK_codigoPlato (codigoPlato),
	constraint FK_Platos_TipoPlato foreign key(codigoTipoPlato)
		references TipoPlato (codigoTipoPlato)
);

CREATE TABLE Empleados(
	codigoEmpleado int not null auto_increment,
	numeroEmpleado int not null,
	apellidosEmpleado varchar(150) not null,
	nombresEmpleado varchar(150) not null,
	direccionEmpleado varchar(150) not null,
	telefonoContacto varchar(10) not null,
	gradoCocinero varchar(50) ,
	codigoTipoEmpleado int not null,
	primary key PK_codigoEmpleado (codigoEmpleado),
	constraint FK_Empleados_TipoEmpleado foreign key(codigoTipoEmpleado)
		references TipoEmpleado (codigoTipoEmpleado)
);

CREATE TABLE ServiciosHasPlatos(
	codigoServiciosHasPlatos int not null auto_increment,
	codigoServicio int not null,
	codigoPlato int not null,
	primary key PK_codigoServiciosHasPlatos (codigoServiciosHasPlatos),
	constraint FK_ServiciosHasPlatos_Servicios foreign key(codigoServicio)
		references Servicios (codigoServicio),
	constraint FK_ServiciosHasPlatos_Platos foreign key(codigoPlato)
		references Platos(codigoPlato)
);
 
CREATE TABLE ServiciosHasEmpleados(
	codigoServicioHasEmpleado int not null auto_increment,
	fechaEvento date not null,
	horaEvento time not null,
	lugarEvento varchar(150) not null,
	codigoServicio int not null,
	codigoEmpleado int not null,
	primary key PK_ServiciosHasEmpleados (codigoServicioHasEmpleado),
	constraint FK_ServiciosHasEmpleados_Servicios foreign key (codigoServicio)
		references Servicios (codigoServicio)
);

CREATE TABLE ProductosHasPlatos(
	codigoProductosHasPlatos int not null auto_increment,
	codigoProducto int not null,
	codigoPlato int not null,
	primary key PK_codigoProductosHasPlatos (codigoProductosHasPlatos),
	constraint FK_ProductosHasPlatos_Productos foreign key(codigoProducto)
		references Productos (codigoProducto),
	constraint FK_ProductosHasPlatos_Platos foreign key(codigoPlato)
		references Platos(codigoPlato)
);
-- ---------------------Agregar TipoEmpleado----------------
Delimiter $$
	Create procedure sp_AgregarTipoEmpleado(in descripcion varchar(100))
		Begin
			Insert into TipoEmpleado (descripcion)
				values(descripcion);
		End$$
Delimiter ;

call sp_AgregarTipoEmpleado('chef');
call sp_AgregarTipoEmpleado('cosinero');

-- ------------------Listar TipoEmpleados------------------
Delimiter $$
	Create procedure sp_ListarTipoEmpleados()
		Begin 
			Select
				T.codigoTipoEmpleado,
                T.descripcion
                from TipoEmpleado T;
		End$$
Delimiter ;

call sp_ListarTipoEmpleados();

-- ----------------Buscar TipoEmpleados----------------

Delimiter $$
	Create procedure sp_BuscarTipoEmpleados(in codTipEmple int )
		Begin
			Select 
				T.codigoTipoEmpleado,
                T.descripcion
				From TipoEmpleado T where codigoTipoEmpleado = codTipEmple;
		End$$
Delimiter ;

call sp_BuscarTipoEmpleados(1);

-- ---------------Editar TipoEmpleados-----------------

Delimiter $$ 
	Create procedure sp_EditarTipoEmpleados(in codTipEmple int, in descr varchar(150))
		Begin 
			update TipoEmpleado T
				set descripcion =descr
                where codigoTipoEmpleado = codTipEmple;
        End$$

Delimiter ;

call sp_EditarTipoEmpleados(1, 'mesero');
call sp_ListarTipoEmpleados();

-- ---------------Eliminar TipoEmpleados-----------------

Delimiter $$
	Create procedure sp_EliminarTipoEmpleados(in codTipEmple int)
		Begin
			Delete From TipoEmpleado
				where codigoTipoEmpleado = codTipEmple;
		End$$
Delimiter ;

call sp_EliminarTipoEmpleados(2);
call sp_ListarTipoEmpleados();

-- ----------------Agregar TipoPlato----------------
Delimiter $$
	Create procedure sp_AgregarTipoPlato(in descripcionTipo varchar(100))
		Begin
			Insert into TipoPlato (descripcionTipo)
				values(descripcionTipo);
		End$$
Delimiter ;

call sp_AgregarTipoPlato('caldo');
call sp_AgregarTipoPlato('sopa');

-- ------------------Listar TipoPlato------------------
Delimiter $$
	Create procedure sp_ListarTipoPlato()
		Begin 
			Select
				T.codigoTipoPlato,
                T.descripcionTipo
                from TipoPlato T;
		End$$
Delimiter ;

call sp_ListarTipoPlato();

-- ----------------Buscar TipoPlato----------------

Delimiter $$
	Create procedure sp_BuscarTipoPlato(in codTipoPla int )
		Begin
			Select 
				T.codigoTipoPlato,
                T.descripcionTipo
				From TipoPlato T where codigoTipoPlato = codTipoPla;
		End$$
Delimiter ;

call sp_BuscarTipoPlato(2);

-- ---------------Editar TipoPlato-----------------

Delimiter $$ 
	Create procedure sp_EditarTipoPlato(in codTipPla int, in descr varchar(150))
		Begin 
			update TipoPlato T
				set descripcionTipo = descr
                where codigoTipoPlato = codTipPla;
        End$$

Delimiter ;

call sp_EditarTipoPlato(1, 'carne');
call sp_ListarTipoPlato();

-- ---------------Eliminar TipoPlato-----------------

Delimiter $$
	Create procedure sp_EliminarTipoPlato(in codTipPla int)
		Begin
			Delete From TipoPlato
				where codigoTipoPlato = codTipPla;
		End$$
Delimiter ;

call sp_EliminarTipoPlato(2);
call sp_ListarTipoPlato();

-- ------------ Agregar Productos ----------------------
Delimiter $$
	Create procedure sp_AgregarProducto(in nombrePro varchar(100), in cant int)
		Begin 
			Insert into Productos (nombreProducto, cantidad)
				values (nombrePro, cant);
			end$$
Delimiter ;
call sp_AgregarProducto('maruchan', 5);
call sp_AgregarProducto('fideos', 10);
-- ----------- Listar Productos ---------------------
Delimiter $$
	Create procedure sp_ListarProducto()
		Begin 
			Select
				P.codigoProducto,
				P.nombreProducto,
				P.cantidad
				from Productos P;
		end$$
Delimiter ;
call sp_ListarProducto;

-- -------------- Buscar Productos -----------------
Delimiter $$
	Create procedure sp_BuscarProducto(in codPro int)
		Begin
			Select 
				P.codigoProducto,
                P.nombreProducto,
                P.cantidad
                from Productos P where codigoProducto = codPro;
			end$$
Delimiter ;
call sp_BuscarProducto(2);

-- ------------------- Editar Productos -------------------
Delimiter $$
	Create procedure sp_EditarProducto(in codPro int, in nombrePro varchar(100), in cant int)
		Begin
			update Productos
            set nombreProducto = nombrePro,
				cantidad = cant
			where codigoProducto = codPro;
		end$$
Delimiter ;
call sp_EditarProducto(1,'Laky men',8);
call sp_ListarProducto;

-- -------------------- Eliminar Producto-------------------
Delimiter $$ 
	Create procedure sp_EliminarProducto(in codPro int)
		Begin
			delete from Productos 
				where codigoProducto = codPro;
			end$$
Delimiter ;
call sp_EliminarProducto(2);
call sp_ListarProducto;

-- ------------ Agregar Empresas----------------------
Delimiter $$
	Create procedure sp_AgregarEmpresa(in nombreEmpre varchar(100),direcci varchar(100),tel varchar(10))
		Begin 
			Insert into Empresas (nombreEmpresa,direccion,telefono)
				values (nombreEmpre,direcci,tel);
			end$$
Delimiter ;
call sp_AgregarEmpresa('Pollo campero','12 av 15-5 zona2','58545625');
call sp_AgregarEmpresa('Burger kin','12 av 15-5 zona8','25897641');
-- ----------- Listar Empresas---------------------
Delimiter $$
	Create procedure sp_ListarEmpresa()
		Begin 
			Select
				E.codigoEmpresa,
                E.nombreEmpresa,
                E.direccion,
                E.telefono
                from Empresas E;
		end$$
Delimiter ;
call sp_ListarEmpresa;

-- -------------- Buscar Empresas-----------------
Delimiter $$
	Create procedure sp_BuscarEmpresa(in codEmpre int)
		Begin
			Select 
				E.codigoEmpresa,
                E.nombreEmpresa,
                E.direccion,
                E.telefono
                from Empresas E where codigoEmpresa = codEmpre;
			end$$
Delimiter ;
call sp_BuscarEmpresa(2);

-- ------------------- Editar Empresas -------------------
Delimiter $$
	Create procedure sp_EditarEmpresa(in codEmpre int,in nombreEmpre varchar(100),in direcci varchar(100),in tel varchar(10))
		Begin
			update Empresas
            set nombreEmpresa = nombreEmpre,
				direccion = direcci,
                telefono =  tel
			where codigoEmpresa = codEmpre;
		end$$
Delimiter ;
call sp_EditarEmpresa(1,'Macdonal','15 av 18-02 zona6','25654798');
call sp_ListarEmpresa;

-- -------------------- Eliminar Empresa-------------------
Delimiter $$ 
	Create procedure sp_EliminarEmpresa(in codEmpre int)
		Begin
			delete from Empresas
				where codigoEmpresa = codEmpre;
			end$$
Delimiter ;
call sp_EliminarEmpresa(2);
call sp_ListarEmpresa;

-- --------------------Agregar Presupuesto -----------------
Delimiter $$
	Create procedure sp_AgregarPresupuesto(in fechaSoli date,in cantPresu decimal(10,2),in codEmpre int)
		Begin
			Insert into Presupuesto (fechaSolicitud,cantidadPresupuesto,codigoEmpresa)
				values (fechaSoli,cantPresu,codEmpre);
			end$$
Delimiter ;
call sp_AgregarPresupuesto('2012-06-20' ,1500,1);
call sp_AgregarPresupuesto('2018-01-18' ,1800,1);

-- --------------------Listar Presupuesto-------------------
Delimiter $$
	Create procedure sp_ListarPresupuesto()
		Begin 
			Select
				P.codigoPresupuesto,
                P.fechaSolicitud,
                P.cantidadPresupuesto,
                P.codigoEmpresa
                from Presupuesto P;
			end$$
Delimiter ;
call sp_ListarPresupuesto;
-- ------------------Buscar Presupuesto------------------
Delimiter $$
	Create procedure sp_BuscarPresupuesto(in codPresu int)
		Begin
			Select 
				P.codigoPresupuesto,
                P.fechaSolicitud,
                P.cantidadPresupuesto,
                P.codigoEmpresa
                from Presupuesto P where codigoPresupuesto = codPresu;
		end$$
Delimiter ;
call sp_BuscarPresupuesto(2)

-- ------------------- Editar Presupuesto -------------------
Delimiter $$
	Create procedure sp_EditarPresupuesto(in codPresu int,in fechaSoli date,in cantPresu decimal(10,2),in codEmpre int)
		Begin
			update Presupuesto
            set fechaSolicitud = fechaSoli,
				cantidadPresupuesto = cantPresu,
                codigoEmpresa =  codEmpre
			where codigoPresupuesto = codPresu;
		end$$
Delimiter ;
call sp_EditarPresupuesto(1,'2020-03-12',2000,1);
call sp_ListarPresupuesto;

-- -------------------- Eliminar Presupuesto-------------------
Delimiter $$ 
	Create procedure sp_EliminarPresupuesto(in codPresu int)
		Begin
			delete from Presupuesto
				where codigoPresupuesto = codPresu;
			end$$
Delimiter ;
call sp_EliminarPresupuesto(2);
call sp_ListarPresupuesto;

-- ---------------------Agregar Servicios----------------
Delimiter $$
	Create procedure sp_AgregarServicio(in fechaServ date,in tipoServ varchar(100),in horaServ time,in lugarServ varchar(100),in telConta varchar(10),in codEmpre int)
		Begin
			Insert into Servicios (fechaServicio,tipoServicio,horaServicio,lugarServicio,telefonoContacto,codigoEmpresa)
				values(fechaServ,tipoServ,horaServ,lugarServ,telConta,codEmpre);
		End$$
Delimiter ;
call sp_AgregarServicio('2021-06-12','Servicio de Buffet','12:20:00','TikalFutura','12356487',1);
call sp_AgregarServicio('2022-09-18','Servicio de Buffet','15:20:00','Kayala','89756212',1);

-- ------------------Listar Servicios------------------
Delimiter $$
	Create procedure sp_ListarServicios()
		Begin 
			Select
				S.codigoServicio, 
				S.fechaServicio, 
				S.tipoServicio, 
				S.horaServicio, 
				S.lugarServicio, 
				S.telefonoContacto, 
				S.codigoEmpresa
                from Servicios S;
				
		End$$
Delimiter ;
call sp_ListarServicios;

-- ----------------Buscar Servicios----------------

Delimiter $$
	Create procedure sp_BuscarServicios(in codServ int )
		Begin
			Select 
				S.codigoServicio, 
				S.fechaServicio, 
				S.tipoServicio, 
				S.horaServicio, 
				S.lugarServicio, 
				S.telefonoContacto, 
				S.codigoEmpresa
                from Servicios S where codigoServicio = codServ;
		End$$
Delimiter ;

call sp_BuscarServicios(1);

-- ---------------Editar Servicios-----------------

Delimiter $$ 
	Create procedure sp_EditarServicio(in codServ int,in fechaServ date,in tipoServ varchar(100),in horaServ time,in lugarServ varchar(100),in telConta varchar(10),in codEmpre int)
		Begin 
			update Servicios S
				set S.fechaServicio = fechaServ, 
					S.tipoServicio = tipoServ, 
					S.horaServicio = horaServ, 
					S.lugarServicio = lugarServ, 
					S.telefonoContacto = telConta, 
					S.codigoEmpresa = codEmpre
                where codigoServicio = codServ;
        End$$
Delimiter ;
call sp_EditarServicio(1,'2022-09-18','Servicio a la Francesa','15:20:00','Kayala','258976420',1);
call sp_ListarServicios();

-- ---------------Eliminar Servicios-----------------

Delimiter $$
	Create procedure sp_EliminarServicios(in codServ int)
		Begin
			Delete From Servicios
				where codigoServicio = codServ;
		End$$
Delimiter ;

call sp_EliminarServicios(2);
call sp_ListarServicios();

-- ----------------Agregar Plato----------------
Delimiter $$
	Create procedure sp_AgregarPlato(in cant int ,in nomPla varchar(100),in descrPla varchar(100),in precPla decimal(5,2),in codTipPla int)
		Begin
			Insert into Platos (cantidad,nombrePlato,descripcionPlato,precioPlato,codigoTipoPlato)
				values(cant,nomPla,descrPla,precPla,codTipPla);
		End$$
Delimiter ;

call sp_AgregarPlato(52,'chao men','fideos con carne',50.25,1);
call sp_AgregarPlato(30,'pizza','pan con salsa',40,1);

-- ------------------Listar Plato------------------
Delimiter $$
	Create procedure sp_ListarPlato()
		Begin 
			Select
				P.codigoPlato,
				P.cantidad,
				P.nombrePlato,
				P.descripcionPlato,
				P.precioPlato, 
				P.codigoPlato
                from Platos P;
		End$$
Delimiter ;
call sp_ListarPlato();

-- ----------------Buscar Plato----------------

Delimiter $$
	Create procedure sp_BuscarPlato(in codPla int )
		Begin
			Select 
				P.codigoPlato,
				P.cantidad,
				P.nombrePlato,
				P.descripcionPlato,
				P.precioPlato, 
				P.codigoTipoPlato
                from Platos P where codigoPlato = codPla;
		End$$
Delimiter ;
call sp_BuscarPlato(1);

-- ---------------Editar Plato-----------------

Delimiter $$ 
	Create procedure sp_EditarPlato( in codPla int ,in cant int ,in nomPla varchar(100),in descrPla varchar(100),in precPla decimal(5,2),in codTipPla int)
		Begin 
			update Platos P
				set P.cantidad = cant,
					P.nombrePlato = nomPla,
					P.descripcionPlato = descrPla,
					P.precioPlato = precPla, 
					P.codigoTipoPlato = codTipPla
                    where codigoPlato = codPla;
        End$$

Delimiter ;

call sp_EditarPlato(1,20,'frijoles','frijoles con huevo',20,1);
call sp_ListarPlato();

-- ---------------Eliminar Plato-----------------

Delimiter $$
	Create procedure sp_EliminarPlato(in codPla int)
		Begin
			Delete From Platos
				where codigoPlato = codPla;
		End$$
Delimiter ;

call sp_EliminarPlato(2);
call sp_ListarPlato();

-- ------------ Agregar Empledos ----------------------
Delimiter $$
	Create procedure sp_AgregarEmpleados(in numEmple int,in apeEmple varchar(100),in nomEmple varchar(100),in direccEmple varchar(100),in telCont varchar(10),in graCoci varchar(50),in codTipEmple int)
		Begin 
			Insert into Empleados (numeroEmpleado,apellidosEmpleado,nombresEmpleado,direccionEmpleado,telefonoContacto,gradoCocinero,codigoTipoEmpleado)
				values (numEmple,apeEmple,nomEmple,direccEmple,telCont,graCoci,codTipEmple);
			end$$
Delimiter ;
call sp_AgregarEmpleados(3,'Lopez','Juan','5av 15-12 zona2','85213647','GradoSuperiordeDireccióndeCocina',1);
call sp_AgregarEmpleados(5,'Ramirez','Roberto','6av 18-13 zona8','85231974','FP Básica de Cocina y Restauración',1);
-- ----------- Listar Empleados---------------------
Delimiter $$
	Create procedure sp_ListarEmpleados()
		Begin 
			Select
				E.codigoEmpleado,
				E.numeroEmpleado,
				E.apellidosEmpleado,
				E.nombresEmpleado,
				E.direccionEmpleado,
				E.telefonoContacto,
				E.gradoCocinero,
				E.codigoTipoEmpleado
				from Empleados E;
		end$$
Delimiter ;
call sp_ListarEmpleados;

-- -------------- Buscar Productos -----------------
Delimiter $$
	Create procedure sp_BuscarEmpleado(in codEmple int)
		Begin
			Select 
				E.codigoEmpleado,
				E.numeroEmpleado,
				E.apellidosEmpleado,
				E.nombresEmpleado,
				E.direccionEmpleado,
				E.telefonoContacto,
				E.gradoCocinero,
				E.codigoTipoEmpleado
				from Empleados E where codigoEmpleado = codEmple;
			end$$
Delimiter ;
call sp_BuscarEmpleado(2);

-- ------------------- Editar Empleados -------------------
Delimiter $$
	Create procedure sp_EditarEmpleado(in codEmple int,in numEmple int,in apeEmple varchar(100),in nomEmple varchar(100),in direccEmple varchar(100),in telCont varchar(10),in graCoci varchar(50),in codTipEmple int)
		Begin
			update Empleados E
            set E.numeroEmpleado = numEmple,
				E.apellidosEmpleado = apeEmple,
				E.nombresEmpleado = nomEmple,
				E.direccionEmpleado = direccEmple,
				E.telefonoContacto = telCont,
				E.gradoCocinero = graCoci,
				E.codigoTipoEmpleado = codTipEmple
			where codigoEmpleado = codEmple;
		end$$
Delimiter ;
call sp_EditarEmpleado(1,5,'Gutieres','Jorge','5av 15-12 zona2','89788779','Grado Superior de Dirección de Cocina',1);
call sp_ListarEmpleados;

-- -------------------- Eliminar Empleado-------------------
Delimiter $$ 
	Create procedure sp_EliminarEmpleado(in codEmple int)
		Begin
			delete from Empleados
				where codigoEmpleado = codEmple;
			end$$
Delimiter ;
call sp_EliminarEmpleado(2);
call sp_ListarEmpleados;

-- ------------ Agregar ServiciosHasPlatos----------------------
Delimiter $$
	Create procedure sp_AgregarServiciosHasPlatos(in codServ int,in codPla int)
		Begin 
			Insert into ServiciosHasPlatos (codigoServicio,codigoPlato)
				values (codServ,codPla);
			end$$
Delimiter ;
call sp_AgregarServiciosHasPlatos(1,1);
call sp_AgregarServiciosHasPlatos(1,1);
-- ----------- Listar ServiciosHasPlatos---------------------
Delimiter $$
	Create procedure sp_ListarServiciosHasPlatos()
		Begin 
			Select
				SHP.codigoServiciosHasPlatos,
                SHP.codigoServicio,
                SHP.codigoPlato
                from ServiciosHasPlatos SHP;
		end$$
Delimiter ;
call sp_ListarServiciosHasPlatos;

-- -------------- Buscar ServiciosHasPlatos-----------------
Delimiter $$
	Create procedure sp_BuscarServiciosHasPlatos(in codSHP int)
		Begin
			Select 
				SHP.codigoServiciosHasPlatos,
                SHP.codigoServicio,
                SHP.codigoPlato
                from ServiciosHasPlatos SHP where codigoServiciosHasPlatos = codSHP;
			end$$
Delimiter ;
call sp_BuscarServiciosHasPlatos(2);

-- ------------------- Editar ServiciosHasPlatos -------------------
Delimiter $$
	Create procedure sp_EditarServiciosHasPlatos(in codSHP int,in codServ int,in codPla int)
		Begin
			update ServiciosHasPlatos
            set codigoServicio = codServ,
				codigoPlato = codPla
			where codigoServiciosHasPlatos = codSHP;
		end$$
Delimiter ;
call sp_EditarServiciosHasPlatos(2,1,1);
call sp_ListarServiciosHasPlatos;

-- -------------------- Eliminar ServiciosHasPlatos-------------------
Delimiter $$ 
	Create procedure sp_EliminarServiciosHasPlatos(in codSHP int)
		Begin
			delete from ServiciosHasPlatos
				where codigoServiciosHasPlatos = codSHP;
			end$$
Delimiter ;
call sp_EliminarServiciosHasPlatos(2);
call sp_ListarServiciosHasPlatos;
-- -----------------------Agregar ServiciosHasEmpleados------------------------
Delimiter $$
	Create procedure sp_AgregarServiciosHasEmpleados(in fechaEvento date, in horaEvento time,in lugarEvento varchar(100),in codServ int,in codEmple int)
		Begin
			Insert into ServiciosHasEmpleados (fechaEvento,horaEvento,lugarEvento,codigoServicio,codigoEmpleado)
				values (fechaEvento,horaEvento,lugarEvento,codServ,codEmple);
			end$$
Delimiter ;
call sp_AgregarServiciosHasEmpleados('2021-05-12','15:20:00','Puerto San Jose',1,1);
call sp_AgregarServiciosHasEmpleados('2021-12-18','09:50:00','Puerto Quetzal',1,1);

-- -----------------------Listar ServiciosHasEmpleados--------------------------
Delimiter $$
	Create procedure sp_ListarServiciosHasEmpleados()
		Begin
			Select 
            SHE.codigoServicioHasEmpleado,
			SHE.fechaEvento,
			SHE.horaEvento,
			SHE.lugarEvento,
			SHE.codigoServicio,
			SHE.codigoEmpleado 
            from ServiciosHasEmpleados SHE;
        end$$
Delimiter ;
call sp_ListarServiciosHasEmpleados();

-- ----------------------Buscar ServiciosHasEmpleados--------------
Delimiter $$
	Create procedure sp_BuscarServiciosHasEmpleados(in codSHE int)
		Begin
			Select 
				SHE.codigoServicioHasEmpleado,
				SHE.fechaEvento,
				SHE.horaEvento,
				SHE.lugarEvento,
				SHE.codigoServicio,
				SHE.codigoEmpleado 
				from ServiciosHasEmpleados SHE where codigoServicioHasEmpleado = codSHE;
		end$$	
Delimiter ;
call sp_BuscarServiciosHasEmpleados(2);
call sp_ListarServiciosHasEmpleados();

-- ----------------------Editar ServiciosHasEmpleados-------------
Delimiter $$
	Create procedure sp_EditarServiciosHasEmpleados(in codSHE int,in fechaEvento date, in horaEvento time,in lugarEvento varchar(100),in codServ int,in codEmple int) 
		Begin 
			update ServiciosHasEmpleados
				set fechaEvento = fechaEvento,
					horaEvento = horaEvento,
                    lugarEvento = lugarEvento,
                    codigoServicio = codServ,
                    codigoEmpleado = codEmple
                    where codigoServicioHasEmpleado = codSHE;
        end$$
Delimiter ;
call sp_EditarServiciosHasEmpleados(1,'2022-07-20','18:20:00','Puerto San Jose',1,1);
call sp_ListarServiciosHasEmpleados();

-- ---------------------Eliminar ServiciosHasEmpleados--------------
Delimiter $$ 
	Create procedure sp_EliminarServiciosHasEmpleados(in codSHE int)
		Begin
			delete from ServiciosHasEmpleados
				where codigoServicioHasEmpleado = codSHE;
			end$$
Delimiter ;
call sp_EliminarServiciosHasEmpleados(2);
call sp_ListarServiciosHasEmpleados;
-- --------------------Agregar ProductosHasPlatos-----------------
Delimiter $$
	Create procedure sp_AgregarProductosHasPlatos(in codProd int, in codPla int)
		Begin
			Insert into ProductosHasPlatos (codigoProducto,codigoPlato)
				values (codProd,codPla);
			end$$
Delimiter ;
call sp_AgregarProductosHasPlatos(1,1);
call sp_AgregarProductosHasPlatos(1,1);

-- --------------------Listar ProductosHasPlatos-------------------
Delimiter $$
	Create procedure sp_ListarProductosHasPlatos()
		Begin 
			Select
				PHP.codigoProductosHasPlatos,
                PHP.codigoProducto,
                PHP.codigoPlato
                from ProductosHasPlatos PHP;
			end$$
Delimiter ;
call sp_ListarProductosHasPlatos;
-- ------------------Buscar ProductosHasPlatos------------------
Delimiter $$
	Create procedure sp_BuscarProductosHasPlatos(in codPHP int)
		Begin
			Select 
				PHP.codigoProductosHasPlatos,
                PHP.codigoProducto,
                PHP.codigoPlato
                from ProductosHasPlatos PHP where codigoProductosHasPlatos = codPHP;
		end$$
Delimiter ;
call sp_BuscarProductosHasPlatos(2);

-- ------------------- Editar ProductosHasPlatos-------------------
Delimiter $$
	Create procedure sp_EditarProductosHasPlatos(in codPHP int,in codProd int,in codPla int)
		Begin
			update ProductosHasPlatos
            set codigoProducto = codProd,
				codigoPlato = codPla
                where codigoProductosHasPlatos = codPHP;
		end$$
Delimiter ;
call sp_EditarProductosHasPlatos(1,1,1);
call sp_ListarProductosHasPlatos;

-- -------------------- Eliminar ProductosHasPlatos-------------------
Delimiter $$ 
	Create procedure sp_EliminarProductosHasPlatos(in codPHP int)
		Begin
			delete from ProductosHasPlatos
				where codigoProductosHasPlatos = codPHP;
			end$$
Delimiter ;
call sp_EliminarProductosHasPlatos(2);
call sp_ListarProductosHasPlatos;

