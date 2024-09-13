show tables;
describe empleados;
describe departamentos;

show columns from empleados;

CREATE TABLE empleados(
id int auto_increment primary KEY,
nombre varchar(50),
apellido varchar(50),
edad int,
salario decimal(10,2),
fecha_contratacion date 
);

--APLICANDO DDL

--1. Modifica la columna "edad" para que no pueda tener valores nulos.
ALTER TABLE empleados MODIFY COLUMN edad INT NOT NULL;

--2. Modifica la columna "salario" para que tenga un valor predeterminado de 0 en lugar de nulo.
ALTER TABLE empleados MODIFY column salario DECIMAL(10,2) default 0;

--3. Agrega una columna llamada "departamento" de tipo VARCHAR(50) para almacenar el departamento al que pertenece cada empleado.
alter table empleados add column departamento varchar(50);

--4. Agrega una columna llamada "correo_electronico" de tipo VARCHAR(100) para almacenar las direcciones de correo electrónico de los empleados.
alter table empleados add column correo_electronico varchar(100);

--5. Elimina la columna "fecha_contratacion" de la tabla "empleados".
alter table empleados drop column fecha_contratacion;

--6. Vuelve a crear la columna "fecha_contratacion" de la tabla "empleados" pero con un valor por default que sea la fecha actual. Para eso puedes usar las funciones “CURRENT_DATE” o “NOW()”.
alter table empleados add column fecha_contratacion date  default (current_date);

--7. Crea una nueva tabla llamada "departamentos" con las siguientes columnas:
create table departamentos(
id int auto_increment primary key,
nombre varchar(50)
);
--8. Agrega una nueva columna llamada "departamento_id" en la tabla "empleados" que servirá como clave foránea para hacer referencia al departamento al que pertenece cada empleado.
alter table empleados add column departamento_id int;

--9.  Modifica la tabla “empleados” y establece una restricción de clave foránea en la columna "departamento_id" para que haga referencia a la columna "id" en la tabla "departamentos".
alter table empleados
add foreign key (departamento_id) references
departamentos(id);

--10.  Elimina el campo “departamentos” de la tabla empleados, ahora usaremos la clave foránea para poder relacionar ambas tablas
alter table empleados drop column departamento;


--APLICANDO DML

--1. Inserta un departamento llamado "Ventas" en la tabla "departamentos".

insert into departamentos(nombre) values ('Ventas');

--2. Inserta un departamento llamado "Recursos Humanos" en la tabla "departamentos".
insert into departamentos(nombre) values ('Recursos Humanos');

--3. Inserta un empleado en la tabla "empleados" con los siguientes valores:
insert into empleados(nombre, apellido, edad, salario, correo_electronico, departamento_id)
values ('Ana', 'Rodriguez', 28, 3000.00, 'anarodriguez@mail.com', 1);

--4. Inserta otro empleado en la tabla "empleados" con los siguientes valores:
insert into empleados(nombre, apellido, edad, salario, correo_electronico, departamento_id)
values ('Carlos', 'López', 32, 3200.50, 'carloslopez@mail.com', 2);

--5. Inserta un empleado en la tabla "empleados" con los siguientes valores:
insert into empleados(nombre, apellido, edad, salario, correo_electronico, departamento_id)
values ('Laura', 'Pérez', 26, 2800.75, 'lauraperez@mail.com', 1);

--6. Inserta otro empleado en la tabla "empleados" con los siguientes valores:
insert into empleados(nombre, apellido, edad, salario, correo_electronico, departamento_id)
values ('Martín', 'González', 30, 3100.25, 'martingonzalez@mail.com', 2);

--7. Actualiza el salario del empleado con nombre "Ana" para aumentarlo en un 10%.
update empleados set salario = salario*1.1 where nombre = 'Ana'; 

--8. Crea un departamento llamado “Contabilidad”. 
insert into departamentos(nombre) values("Contabilidad");

--9. Cambia el departamento del empleado con nombre "Carlos" de "Recursos Humanos" a "Contabilidad":

update empleados set departamento_id = 3 where nombre = 'Carlos';

--10. Elimina al empleado con nombre "Laura"
delete from empleados where nombre = 'Laura';

show variables LIKE  'sql_safe_updates';

--11. Haz una consulta simple de los datos de la tabla empleados y verifica que se presente de la siguiente manera:

select * from empleados;
--12. Haz una consulta simple de los datos de la tabla departamentos y verifica que se presente de la siguiente manera:
select * from departamentos;

--DML: Repaso

--1. Crea una tabla llamada "clientes" con columnas para el "id" (entero autoincremental), "nombre" (cadena de hasta 50 caracteres), y "direccion" (cadena de hasta 100 caracteres).

create table clientes(
    id int auto_increment primary key,
    nombre varchar(50),
    direccion varchar(100)
);

--2. Crea una tabla llamada "productos" con columnas para el "id" (entero autoincremental), "nombre" (cadena de hasta 50 caracteres), y "precio" (decimal con 10 dígitos, 2 decimales).

create table productos (
    id int auto_increment primary key,
    nombre varchar(50),
    precio decimal(10,2)
);

--3. Crea una tabla llamada "ventas" con columnas para "id" (entero autoincremental), "producto_id" (entero), "cliente_id" (entero), "cantidad" (entero), “precio_unitario” (decimal con 10 dígitos, 2 decimales), "monto_total" (decimal con 10 dígitos, 2 decimales), y "empleado_id" (entero).

create table ventas(
    id int auto_increment primary key,
    producto_id int,
    cliente_id int,
    cantidad int,
    precio_unitario decimal(10,2),
    monto_total decimal(10,2),
    empleado_id int
);

--4. En la tabla creada Ventas, establece restricciones de clave foránea en las columnas "producto_id," "cliente_id," y "empleado_id" para hacer referencia a las tablas correspondientes. 

alter table ventas
add foreign key (producto_id) 
references productos(id),
add foreign key (cliente_id) 
references clientes(id),
add foreign key (empleado_id) 
references empleados(id);

--5. Inserta un nuevo cliente en la tabla "clientes" con el nombre "Juan Pérez" y la dirección "Libertad 3215, Mar del Plata"
insert into clientes(nombre, direccion) values ('Juan Pérez', 'Libertad 3215, Mar del Plata');

--6. Inserta un nuevo producto en la tabla "productos" con el nombre "Laptop" y un precio de 1200.00 .
insert into productos(nombre, precio) values ('Laptop', 1200.00);

--7. Modifica la columna monto_total de la tabla ventas para que por defecto sea el resultado de multiplicar la cantidad por el precio del producto_id

alter table ventas 
MODIFY column monto_total decimal(10,2) generated always as (cantidad * precio_unitario) stored;

--8. 8. Crea una venta en la tabla "ventas" donde el cliente "Juan Pérez" compra "Laptop" por una cantidad de 2 unidades y el vendedor tenga el nombre “Ana" y apellido "Rodriguez”. Ten en cuenta que debes “tener” los ID y valores correspondientes previamente, luego aprenderemos a recuperarlos con subconsultas.

insert into ventas(cliente_id, producto_id, cantidad, empleado_id, precio_unitario) values (1, 1, 2, 1, 1200.00);

--DML - Continuando con la práctica

--1. Inserta un nuevo producto en la tabla "productos" con el nombre "Teléfono móvil" y un precio de 450.00.

insert into productos(nombre, precio) values('Teléfono móvil', 450.00);

--2. Inserta un nuevo cliente en la tabla "clientes" con el nombre "María García" y la dirección "Constitución 456, Luján".

insert into clientes(nombre, direccion) values ('María García', 'Constitución 456, Luján');

--3. Modifica la columna correo_electronico de la tabla empleados para que se genere automáticamente concatenado el nombre, apellido y el string “@mail.com”.

alter table empleados
MODIFY correo_electronico  varchar(100)
generated always as (concat(nombre, apellido, '@mail.com')) stored;

--4. Inserta un nuevo empleado en la tabla "empleados" con el nombre "Luis” y apellido “Fernández", edad 28, salario 2800.00 y que pertenezca al departamento “ventas”.

insert into empleados(nombre, apellido, edad, salario, departamento_id) 
values ('Luis', 'Fernández', 28, 2800.00, (select id from departamentos where nombre='Ventas'));

--5. Actualiza el precio del producto "Laptop" a 1350.00 en la tabla "productos".
-- select precio FROM productos where nombre = 'Laptop';

update productos set precio =  1350.00 where nombre ='Laptop';

--6. Modifica la dirección del cliente "Juan Pérez" a "Alberti 1789, Mar del Plata" en la tabla "clientes".

update clientes set direccion = 'Alberti 1789, Mar del Plata' where nombre = 'Juan Pérez';

--7. Incrementa el salario de todos los empleados en un 5% en la tabla "empleados".

update empleados set salario = salario * 1.05 ;

--8. Inserta un nuevo producto en la tabla "productos" con el nombre "Tablet" y un precio de 350.00.

insert into productos(nombre, precio) values ('Tablet', 350.00);

--9. Inserta un nuevo cliente en la tabla "clientes" con el nombre "Ana López" y la dirección "Beltrán 1452, Godoy Cruz".

insert into clientes(nombre, direccion) values ('Ana López', 'Beltrán 1452, Godoy Cruz');


--10. Inserta un nuevo empleado en la tabla "empleados" con el nombre "Marta", apellido "Ramírez", edad 32, salario 3100.00 y que pertenezca al departamento “ventas”.


insert into empleados(nombre, apellido, edad, salario, departamento_id) 
values ('Martha', 'Ramírez', 32, 3100.00, (select id from departamentos where nombre='Ventas'));

--11. Actualiza el precio del producto "Teléfono móvil" a 480.00 en la tabla "productos".
update productos set precio = 480.00 where nombre = 'Teléfono móvil';

--12. Modifica la dirección del cliente "María García" a "Avenida 789, Ciudad del Este" en la tabla "clientes".

update clientes set direccion = 'Avenida 789, Ciudad del Este' where nombre = 'María García';

--13. Incrementa el salario de todos los empleados en el departamento de "Ventas" en un 7% en la tabla "empleados".

update empleados set salario = salario*1.07 
where departamento_id = (select id from departamentos where nombre = 'Ventas');

--14. Inserta un nuevo producto en la tabla "productos" con el nombre "Impresora" y un precio de 280.00.

insert into productos(nombre, precio) values ('Impresora', 280.00);

--15. Inserta un nuevo cliente en la tabla "clientes" con el nombre "Carlos Sánchez" y la dirección "Saavedra 206, Las Heras".

insert into clientes(nombre, direccion) values ('Carlos Sánchez', 'Saavedra 206, Las Heras' );

--16. Inserta un nuevo empleado en la tabla "empleados" con el nombre "Lorena", apellido "Guzmán", edad 26, salario 2600.00 y que pertenezca al departamento “ventas”.

insert into empleados(nombre, apellido, edad, salario, departamento_id) 
values ('Lorena', 'Guzmán', 26, 2600.00, (select id from departamentos where nombre='Ventas'));

--17. Haz una consulta simple de los datos de la tabla empleados y verifica que se presente de la siguiente manera:

select * from empleados;

--18. Haz una consulta simple de los datos de la tabla clientes y verifica que se presente de la siguiente manera:

select * from clientes;

--19. Haz una consulta simple de los datos de la tabla productos y verifica que se presente de la siguiente manera:

select * from productos;