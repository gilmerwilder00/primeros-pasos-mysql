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

--Actividad: Ejercicios Complementarios

--1.  Inserta una venta en la tabla "ventas" donde el cliente "Juan Pérez" compra una "Laptop" con una cantidad de 2 y el vendedor tiene el nombre "Ana" y apellido "Rodríguez".

insert into ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
values (
    (select id from productos where nombre = 'Laptop'),
    (select id from clientes where nombre = 'Juan Pérez'),
    2,
    1350.00,
    (select id from empleados where nombre = 'Ana')
);

--2. Inserta una venta en la tabla "ventas" donde el cliente "María García" compra un "Teléfono móvil" con una cantidad de 3 y el vendedor tiene el nombre "Carlos" y apellido "López".

insert into ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
values (
    (select id from productos where nombre = 'Teléfono móvil'),
    (select id from clientes where nombre = 'María García'),
    3,
    480.00,
    (select id from empleados where nombre = 'Carlos' and apellido ='López')
);

--3. Crea una venta en la tabla "ventas" donde el cliente "Carlos Sánchez" compra una "Impresora" con una cantidad de 1 y el vendedor tiene el nombre "Marta" y apellido "Ramírez".

insert into ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
values (
    (select id from productos where nombre = 'Impresora'),
    (select id from clientes where nombre = 'Carlos Sánchez'),
    1,
    280.00,
    (select id from empleados where nombre = 'Martha' and apellido ='Ramírez')
);

--4. Inserta una venta en la tabla "ventas" donde el cliente "Ana López" compra una "Laptop" con una cantidad de 1 y el vendedor tiene el nombre "Carlos" y apellido "López".

insert into ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
values (
    (select id from productos where nombre = 'Laptop'),
    (select id from clientes where nombre = 'Ana López'),
    1,
    1350.00,
    (select id from empleados where nombre = 'Carlos' and apellido ='López')
);

--5. Crea una venta en la tabla "ventas" donde el cliente "Juan Pérez" compra una "Tablet" con una cantidad de 2 y el vendedor tiene el nombre "Luis" y apellido "Fernández".

insert into ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
values (
    (select id from productos where nombre = 'Tablet'),
    (select id from clientes where nombre = 'Juan Pérez'),
    2,
    350.00,
    (select id from empleados where nombre = 'Luis' and apellido ='Fernández')
);

--6.  Inserta una venta en la tabla "ventas" donde el cliente "María García" compra un "Teléfono móvil" con una cantidad de 1 y el vendedor tiene el nombre "Marta" y apellido "Ramírez".

insert into ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
values (
    (select id from productos where nombre = 'Teléfono móvil'),
    (select id from clientes where nombre = 'María García'),
    1,
    480.00,
    (select id from empleados where nombre = 'Martha' and apellido ='Ramírez')
);


--7. Crea una venta en la tabla "ventas" donde el cliente "Carlos Sánchez" compra una "Impresora" con una cantidad de 2 y el vendedor tiene el nombre "Lorena" y apellido "Guzmán".

insert into ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
values (
    (select id from productos where nombre = 'Impresora'),
    (select id from clientes where nombre = 'Carlos Sánchez'),
    2,
    280.00,
    (select id from empleados where nombre = 'Lorena' and apellido ='Guzmán')
);

--8. Haz una consulta simple de los datos de la tabla ventas y verifica que se presente de la siguiente manera:

select * from ventas;

--SELECT avanzado

--Ejercicios: Cláusula DISTINCT

--1. Lista los nombres de los empleados sin duplicados

select  DISTINCT nombre from empleados;

--2. Obtén una lista de correos electrónicos únicos de todos los empleados.

select  DISTINCT correo_electronico from empleados;

--3. Encuentra la lista de edades distintas entre los empleados.

select DISTINCT edad from empleados;


--Ejercicios: Operadores relacionales

--1. Muestra los nombres de los empleados que tienen un salario superior a $3200.
select * 
from empleados e
where e.salario > 3200;

--2. Obtén una lista de empleados que tienen 28 años de edad.
select * 
from empleados e
where e.edad =28;

--3. Lista a los empleados cuyos salarios sean menores a $2700.
select * 
from empleados e 
where e.salario < 2700;

--4. Encuentra todas las ventas donde la cantidad de productos vendidos sea mayor que 2.

select * 
from ventas v 
where v.cantidad > 2;

--5. Muestra las ventas donde el precio unitario sea igual a $480.00.

select * 
from ventas v   
where v.precio_unitario = 480.00;

--6. Obtén una lista de ventas donde el monto total sea menor que $1000.00.

select * 
from ventas v   
where v.monto_total < 1000.00;

--7. Encuentra las ventas realizadas por el empleado con el ID 1.

select * 
from ventas v  
where empleado_id = 1;

-- Ejercicios: Operadores lógicos

--1. Muestra los nombres de los empleados que trabajan en el Departamento 1 y tienen un salario superior a $3000.

select e.nombre
from empleados e
where e.departamento_id = 1 and  
      e.salario > 3000.00;

--2. Lista los empleados que tienen 32 años de edad o trabajan en el Departamento 3.

select *
from empleados e
where e.edad = 32 or
    e.departamento_id = 3;

--3. Lista las ventas donde el producto sea el ID 1 y la cantidad sea mayor o igual a 2.
select *
from ventas v
where v.producto_id = 1 and  
      v.cantidad >= 2;

--4. Muestra las ventas donde el cliente sea el ID 1 o el empleado sea el ID 2.

select *
from ventas v  
where v.cliente_id = 1 or 
    v.empleado_id =2;

--5. Obtén una lista de ventas donde el cliente sea el ID 2 y la cantidad sea mayor que 2.

select *
from ventas v 
where v.cliente_id = 2 and 
    v.cantidad > 2;

--6. Encuentra las ventas realizadas por el empleado con el ID 1 y donde el monto total sea mayor que $2000.00.

select *
from ventas v 
where v.empleado_id = 1 and 
    v.monto_total > 2000.00;

-- Ejercicios: Cláusula BETWEEN

--1. Encuentra a los empleados cuyas edades están entre 29 y 33 años. Muestra el nombre y la edad de los registros que cumplan esa condición. 

select *
from empleados e 
where e.edad  BETWEEN 29 and 33;

--2. Encuentra las ventas donde la cantidad de productos vendidos esté entre 2 y 3.

select * 
from ventas v 
where v.cantidad BETWEEN 2 and 3;

--3. Muestra las ventas donde el precio unitario esté entre $300.00 y $500.00.

select *
from ventas v 
where v.precio_unitario BETWEEN 300.00 and 500.00;

--Carga de datos

show databases;
use mi_bd;

show tables;

INSERT INTO empleados (nombre, apellido, edad, salario, departamento_id)
VALUES
  ('Laura', 'Sánchez', 27, 3300.00, 1),
  ('Javier', 'Pérez', 29, 3100.00, 1),
  ('Camila', 'Gómez', 26, 3000.00, 1),
  ('Lucas', 'Fernández', 28, 3200.00, 1),
  ('Valentina', 'Rodríguez', 30, 3500.00, 1);

INSERT INTO productos (nombre, precio)
VALUES
  ('Cámara Digital', 420.00),
  ('Smart TV 55 Pulgadas', 1200.00),
  ('Auriculares Bluetooth', 80.00),
  ('Reproductor de Blu-ray', 120.00),
  ('Lavadora de Ropa', 550.00),
  ('Refrigeradora Doble Puerta', 800.00),
  ('Horno de Microondas', 120.00),
  ('Licuadora de Alta Potencia', 70.00),
  ('Silla de Oficina Ergonómica', 150.00),
  ('Escritorio de Madera', 200.00),
  ('Mesa de Comedor', 250.00),
  ('Sofá de Tres Plazas', 350.00),
  ('Mochila para Portátil', 30.00),
  ('Reloj de Pulsera Inteligente', 100.00),
  ('Juego de Utensilios de Cocina', 40.00),
  ('Set de Toallas de Baño', 20.00),
  ('Cama King Size', 500.00),
  ('Lámpara de Pie Moderna', 70.00),
  ('Cafetera de Goteo', 40.00),
  ('Robot Aspirador', 180.00);
INSERT INTO clientes (nombre, direccion)
VALUES
  ('Alejandro López', 'Calle Rivadavia 123, Buenos Aires'),
  ('Sofía Rodríguez', 'Avenida San Martín 456, Rosario'),
  ('Joaquín Pérez', 'Calle Belgrano 789, Córdoba'),
  ('Valeria Gómez', 'Calle Mitre 101, Mendoza'),
  ('Diego Martínez', 'Avenida 9 de Julio 654, Buenos Aires');
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
VALUES
  (1, 6, 3, 1350.00, 1),
  (5, 8, 5, 420.00, 9),
  (10, 2, 2, 800.00, 6),
  (14, 7, 1, 200.00, 5),
  (20, 4, 4, 20.00, 6),
  (4, 5, 5, 280.00, 1),
  (9, 5, 3, 550.00, 1),
  (13, 3, 4, 150.00, 5),
  (19, 6, 2, 40.00, 1),
  (2, 9, 5, 480.00, 1);
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
VALUES
  (3, 9, 1, 350.00, 1),
  (6, 7, 4, 1200.00, 1),
  (7, 6, 3, 80.00, 1),
  (12, 9, 5, 70.00, 1),
  (16, 8, 2, 350.00, 6),
  (23, 9, 4, 180.00, 1),
  (18, 4, 3, 100.00, 7),
  (11, 3, 2, 120.00, 5),
  (15, 5, 4, 250.00, 6),
  (8, 8, 1, 120.00, 7);
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
VALUES
  (17, 3, 2, 30.00, 5),
  (21, 9, 5, 500.00, 6),
  (22, 2, 3, 70.00, 6),
  (24, 9, 2, 180.00, 1),
  (5, 1, 2, 1350.00, 1),
  (9, 6, 4, 550.00, 9),
  (13, 8, 3, 150.00, 7),
  (3, 1, 5, 350.00, 1),
  (18, 9, 1, 100.00, 6),
  (10, 5, 2, 800.00, 1);
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
VALUES
  (7, 4, 3, 80.00, 6),
  (2, 5, 1, 480.00, 6),
  (8, 7, 4, 120.00, 7),
  (1, 3, 5, 1350.00, 5),
  (4, 6, 2, 280.00, 5),
  (12, 1, 1, 70.00, 1),
  (19, 4, 3, 40.00, 6),
  (15, 3, 4, 250.00, 5),
  (6, 8, 2, 1200.00, 7),
  (11, 2, 3, 120.00, 5);

-- 
-- Ejercicios cláusula IN

--1.  Encuentra los empleados cuyos IDs son 1, 3 o 5.

select *
from empleados
where id in (1, 2, 5);

select id, nombre Nombre, apellido Apellido
from empleados
where id  in (1,2,5);

select e.id, e.nombre, e.apellido
from empleados e
where e.id in (1,2,5);

--2. Busca los productos con IDs 2, 4 o 6 en la tabla de productos.

select *
from productos p 
where p.id in (2,4,6);

--3.  Encuentra las ventas que tienen los clientes con IDs 1, 3 o 5.

select *
from ventas v  
where v.cliente_id in (1,3,5);

-- Ejercicios cláusula LIKE

-- 1. Encuentra los empleados cuyos nombres comienzan con "L".

select *
from empleados e
where e.nombre like 'L%';

--2. Busca los productos cuyos nombres contengan la palabra "Teléfono".

select *
from productos p
where p.nombre like '%Teléfono%';

--3. Encuentra los clientes cuyas direcciones contienen la palabra "Calle".

select *
from clientes c  
where c.direccion like '%Calle%';

--Extra: uso de '_'
select *
from empleados 
where nombre like '_a%';

--Ejercicios cláusula ORDER BY:

--1. Ordena los empleados por salario de manera ascendente.

select *
from empleados 
order by salario ;

--2. Ordena los productos por nombre de manera descendente.

select * 
from productos
order by nombre desc; 

--3. Ordena las ventas por cantidad de manera ascendente y luego por precio_unitario de manera descendente.

select *
from ventas
order by cantidad asc, precio_unitario desc;

--Ejercicios LIMIT

--1. Muestra los 5 productos más caros de la tabla "productos".

select *
from productos
order by precio desc
limit 5;

--2. Muestra los 10 primeros empleados en orden alfabético por apellido.

select *
from empleados
order by apellido asc
limit 10;

--3. Muestra las 3 ventas con el monto total más alto.

select *
from ventas 
order by monto_total desc
limit 3; 

--Ejercicios AS

--1. Crea una consulta que muestre el salario de los empleados junto con el salario aumentado en un 10% nombrando a la columna como “Aumento del 10%”.

select nombre, apellido, salario, (salario*1.1) as "Aumento del 10%" 
from empleados; 

--2. Crea una consulta que calcule el monto total de las compras realizadas por cliente y que la columna se llame “Monto total gastado”.

select cliente_id, sum(monto_total) as "Monto total gastado"
from ventas
group by cliente_id;

--3. Muestra los nombres completos de los empleados concatenando los campos "nombre" y "apellido" y que la columna se llame “Nombre y apellido”.

select e.nombre, e.apellido, concat(e.nombre, ' ' ,e.apellido) as "Nombre y Apellido"
from empleados e;

-- Ejercicios CASE


--1. Crea una consulta que muestre el nombre de los productos y los categorice como "Caro" si el precio es mayor o igual a $500, "Medio" si es mayor o igual a $200 y menor que $500, y "Barato" en otros casos.

select p.nombre,
    CASE
        when p.precio >= 500.00 then 'Caro'
        when p.precio >= 200.00 then 'Medio'
        else 'Barato'
    end as "Categoría",
    p.precio
from productos p;

--2. Crea una consulta que muestre el nombre de los empleados y los categorice como "Joven" si tienen menos de 30 años, "Adulto" si tienen entre 30 y 40 años, y "Mayor" si tienen más de 40 años.

select e.nombre,
    CASE
        when e.edad < 30 then 'Joven'
        when e.edad >=30 and edad <= 40 then 'Adulto'
        else 'Mayor'
    end as "Categoría",
    e.edad
from empleados e;

--3. Crea una consulta que muestre el ID de la venta y los categorice como "Poca cantidad" si la cantidad es menor que 3, "Cantidad moderada" si es igual o mayor que 3 y menor que 6, y "Mucha cantidad" en otros casos.

select  v.id, 
        v.cantidad,
        CASE
            when v.cantidad < 3 then 'Poca cantidad'
            when v.cantidad >= 3 and v.cantidad < 6 then 'Cantidad Moderada'
            else 'Mucha cantidad'
        end as "Categoría"
from ventas v
order by v.cantidad;

--4. Crea una consulta que muestre el nombre de los clientes y los categorice como "Comienza con A" si su nombre comienza con la letra 'A', "Comienza con M" si comienza con 'M' y "Otros" en otros casos.

select c.nombre,
        CASE
            when c.nombre like 'A%' then "Comienza con A"
            when c.nombre like 'M%' then "Comienza con M"
            else 'Otros'
        end as "Categoría"
from clientes c;

--5. Crea una consulta que muestre el nombre de los empleados y los categorice como "Salario alto" si el salario es mayor o igual a $3500, "Salario medio" si es mayor o igual a $3000 y menor que $3500, y "Salario bajo" en otros casos.

select e.nombre,
        CASE
            when e.salario >= 3500.00 then 'Salario alto'
            when e.salario >= 3000.00 then 'Salario medio'
            else 'Salario bajo'
        end as "Cateroría", 
        e.salario
from empleados e
order by e.salario;

--Practicando con funciones avanzadas

--Ejercicios Función MAX() 

--1. Encuentra el salario máximo de todos los empleados.
select max(salario)
from empleados;

--2. Encuentra la cantidad máxima de productos vendidos en una sola venta.
select max(v.cantidad)
from ventas v;

--3. Encuentra la edad máxima de los empleados.
select max(e.edad)
from empleados e;

--Ejercicios Función MIN()

--1. Encuentra el salario mínimo de todos los empleados.
select min(salario)
from empleados;
--2. Encuentra la cantidad mínima de productos vendidos en una sola venta.
select min(v.cantidad)
from ventas v;
--3. Encuentra la edad mínima de los empleados.
select min(e.edad)
from empleados e;


-- Ejercicios de la Función COUNT()
--1.Cuenta cuántos empleados hay en total.

select count(*)
from empleados;

--2. Cuenta cuántas ventas se han realizado.
select count(*)
from ventas;

--3. Cuenta cuántos productos tienen un precio superior a $500.

select count(*)
from productos
where precio >500;


--Ejercicios de la Función SUM()

--1. Calcula la suma total de salarios de todos los empleados.
select sum(salario)
from empleados;

--2. Calcula la suma total de montos vendidos en todas las ventas.
select sum(monto_total)
from ventas;

--3. Calcula la suma de precios de productos con ID par.
select sum(precio)
from productos
where mod(id, 2) = 0 ;

--Ejercicios Función AVG()
--1. Calcula el salario promedio de todos los empleados.
select avg(salario)
from empleados;
--2. Calcula el precio unitario promedio de todos los productos.
select avg(precio)
from productos;
--3. Calcula la edad promedio de los empleados.
select avg(edad)
from empleados;

--Ejercicios GROUP BY()

--1. Agrupa las ventas por empleado y muestra la cantidad total de ventas realizadas por cada empleado.
select  empleado_id,
        sum(monto_total)
from ventas v  
group by empleado_id;


--2. Agrupa los productos por precio y muestra la cantidad de productos con el mismo precio.
select precio, count(*)
from productos
group by precio;

--3. Agrupa los empleados por departamento y muestra la cantidad de empleados en cada departamento.

select departamento_id, count(*)
from empleados 
group by departamento_id;

--Ejercicios HAVING 
--1. Encuentra los departamentos con un salario promedio de sus empleados superior a $3,000.

select departamento_id, 
       (select d.nombre from departamentos d where d.id = e.departamento_id),
       avg(salario) promedio
from empleados e
group by departamento_id
having promedio > 3000.00;

--2. Encuentra los productos que se han vendido al menos 5 veces.

select v.producto_id,
       (select  p.nombre from productos p where p.id = v.producto_id) nombre ,
        count(*) cantidad
from ventas v
group by v.producto_id
having cantidad>=5;

--3. Selecciona los empleados que tengan una “o” en su nombre o apellido y agrúpalos por departamento y muestra los que tengan el salario máximo.

select departamento_id, 
       (select nombre from departamentos d where d.id = e.departamento_id) nombre, 
    max(e.salario) salario_maximo
from empleados e  
where e.nombre like '%o%' or e.apellido like '%o%'
group by e.departamento_id;

-- Ejercicios consultas multitabla  - Parte 1

--1. Une las tablas de empleados con departamentos y solo muestra las columnas nombre, apellido, edad, salario de empleados y la columna nombre de departamentos.

select e.nombre, e.apellido, e.edad , e.salario, d.nombre departamento
from empleados e, departamentos d
where  e.departamento_id = d.id

--2. Une las tablas ventas con la tabla empleados donde se muestren todas las columnas de ventas exceptuando la columna empleado_id y en su lugar muestres el nombre y apellido de la tabla empleados.

select v.id, v.producto_id, v.cliente_id, v.cantidad, v.precio_unitario, v.monto_total, e.nombre nombre_empleado , e.apellido apellido_empleado
from ventas v, empleados e
where v.empleado_id = e.id;

--3. Une las tablas ventas con la tabla productos donde se muestren todas las columnas de ventas exceptuando la columna producto_id y en su lugar muestres la columna nombre de la tabla productos.

select  v.id, p.nombre producto , v.cliente_id, v.cantidad, v.precio_unitario, v.monto_total
from ventas v, productos p
where v.producto_id = p.id;

--4. Une las tablas ventas con la tabla clientes donde se muestren todas las columnas de ventas exceptuando la columna cliente_id y en su lugar muestres la columna nombre de la tabla clientes.

select  v.id, v.producto_id , c.nombre cliente, v.cantidad, v.precio_unitario, v.monto_total
from ventas v, clientes c
where v.cliente_id = c.id;

--5. Une las tablas ventas con la tablas empleados y departamentos donde se muestren todas las columnas de ventas exceptuando la columna empleado_id y en su lugar muestres el nombre y apellido de la tabla empleados y además muestres la columna nombre de la tabla departamentos.

select v.id, v.producto_id, v.cliente_id, v.cantidad, v.precio_unitario, v.monto_total, concat(e.nombre,' ' ,e.apellido) empleado, d.nombre departamento
from ventas v, empleados e, departamentos d
where v.empleado_id = e.id and
    e.departamento_id = d.id; 

--6. Une las tablas ventas, empleados, productos y clientes donde se muestren las columnas de la tabla ventas reemplazando sus columnas de FOREIGN KEYs con las respectivas columnas de “nombre” de las otras tablas.

select v.id, p.nombre producto, c.nombre cliente, v.cantidad, v.precio_unitario, v.monto_total,e.nombre empleado
from ventas v, empleados e, productos p, clientes c
where v.empleado_id = e.id and
    v.producto_id = p.id and  
    v.cliente_id = c.id;

--7. Calcular el salario máximo de los empleados en cada departamento y mostrar el nombre del departamento junto con el salario máximo.

select d.nombre departamento, max(salario) salario_maximo
from departamentos d, empleados e
where d.id = e.departamento_id 
group by departamento;

--Ejercicios consultas multitabla - Parte 2 

--1. Calcular el monto total de ventas por departamento y mostrar el nombre del departamento junto con el monto total de ventas.

select d.nombre departamento, sum(monto_total)
from ventas v , empleados e , departamentos d 
where v.empleado_id = e.id and
    e.departamento_id = d.id
group by departamento;

--select DISTINCT empleado_id
--from ventas v; (1,2,5,6,7,9)

--select nombre,
--    (select nombre from departamentos d where d.id = e.departamento_id)
--from empleados e
--where e.id in (1,2,5,6,7,9);

--2. Encontrar el empleado más joven de cada departamento y mostrar el nombre del departamento junto con la edad del empleado más joven.

select d.nombre departamento, min(e.edad) edad
from empleados e, departamentos d
where e.departamento_id = d.id
group by departamento
order by edad desc;

--3. Calcular el volumen de productos vendidos por cada producto (por ejemplo, menos de 5 “bajo”, menos 8 “medio” y mayor o igual a 8 “alto”) y mostrar la categoría de volumen junto con la cantidad y el nombre del producto.

SELECT 
    CASE 
        when sum(cantidad) <  5 then 'Bajo'
        when sum(cantidad) <  8 then 'Medio'
        else 'Alto'
    end as categoria_volumen,
    sum(cantidad) cantidad_total,
    p.nombre producto 
from ventas v, productos p
where v.producto_id = p.id
group by producto
order by cantidad_total desc;


--4. Encontrar el cliente que ha realizado el mayor monto total de compras y mostrar su nombre y el monto total.

select c.nombre cliente, max(v.monto_total) monto_total
from ventas v, clientes c 
where v.cliente_id = c.id
group by cliente
order by monto_total desc
limit 1;

--5. Calcular el precio promedio de los productos vendidos por cada empleado y mostrar el nombre del empleado junto con el precio promedio de los productos que ha vendido.

select e.nombre 'Nombre empleado', avg(p.precio) 'Monto promedio ventas'
from ventas v , empleados e, productos p
where v.empleado_id = e.id and
    v.producto_id =  p.id
group by e.nombre
order by 2 desc;

--6. Encontrar el departamento con el salario mínimo más bajo entre los empleados y mostrar el nombre del departamento junto con el salario mínimo más bajo.

select  d.nombre Departamento, min(e.salario) 'Salario más bajo'
from departamentos d, empleados e
where d.id = e.departamento_id
group by d.nombre;

--7. Encuentra el departamento con el salario promedio más alto entre los empleados mayores de 30 años y muestra el nombre del departamento junto con el salario promedio. Limita los resultados a mostrar solo los departamentos con el salario promedio mayor a 3320.

select d.nombre 'Nombre departamento', avg(e.salario)
from departamentos d, empleados e
where d.id = e.departamento_id and 
    e.edad >30
group by d.nombre
having avg(e.salario) > 3320.00;


-- Ejercicios JOIN Parte 1

--1. Encuentra el nombre y apellido de los empleados junto con la cantidad total de ventas que han realizado.

use mi_bd;

select e.nombre nombre_empleado , e.apellido apellido_empleado, sum(v.cantidad) cantidad
from empleados e
inner join ventas v
on e.id = v.empleado_id
group by nombre_empleado, apellido_empleado
order by cantidad desc;

--2. Calcula el monto total vendido a cada cliente y muestra el nombre del cliente, su dirección y el monto total.

select c.nombre 'Nombre cliente', c.direccion 'Dirección cliente', sum(monto_total) 'Monto total'
from clientes c
join ventas v
on c.id = v.cliente_id
group by c.nombre, c.direccion
order by 3 desc;

--3. Encuentra los productos vendidos por cada empleado en el departamento de "Ventas" y muestra el nombre del empleado junto con el nombre de los productos que han vendido.


select DISTINCT e.nombre 'Nombre empleado', p.nombre 'Nombre producto' 
from ventas v 
inner join empleados e
    on v.empleado_id = e.id
inner join productos p
    on v.producto_id = p.id
where e.departamento_id = (select id from departamentos d where d.nombre = 'Ventas')
order by 1;

--4. Encuentra el nombre del cliente, el nombre del producto y la cantidad comprada de productos con un precio superior a $500.

select  c.nombre 'Nombre de cliente', p.nombre 'Producto', sum(v.cantidad) Cantidad, p.precio
from clientes c
inner join ventas v 
    on c.id = v.cliente_id
inner join productos p
    on v.producto_id  =  p.id
where p.precio > 500.00
GROUP BY c.nombre, p.nombre, p.precio
order by p.precio desc
;

select * from ventas order by producto_id;

--Ejercicios JOIN Parte 2

--1. Calcula la cantidad de ventas por departamento, incluso si el departamento no tiene ventas.

use mi_bd;

select d.id, d.nombre Departamento, count(v.id) 'Cantidad de ventas'
from departamentos d
left join empleados e
on d.id = e.departamento_id
left join ventas v  
on v.empleado_id = e.id
group by d.id;


--2. Encuentra el nombre y la dirección de los clientes que han comprado más de 3 productos y muestra la cantidad de productos comprados.

select c.nombre Cliente, c.direccion Direción,  count( DISTINCT v.producto_id) 'Cantidad de productos'
from clientes c
left join ventas v
on c.id = v.cliente_id
group by c.nombre, c.direccion
having count(DISTINCT v.producto_id) > 3
order by 3 desc;

--3. Calcula el monto total de ventas realizadas por cada departamento y muestra el nombre del departamento junto con el monto total de ventas.

select d.nombre Departamento, sum(v.monto_total) 'Monto total ventas'
from departamentos d
left join empleados e
on d.id = e.departamento_id
left join ventas v
on v.empleado_id = e.id
group by d.nombre;

--Actividad: Ejercicios Complementarios
-- Estos ejercicios son de tipo complementario. Esto quiere decir que te ayudará a avanzar en profundidad en el tema visto, pero no son obligatorios. Te recomendamos intentar con tu equipo trabajar algunos de ellos. 

--1. Muestra el nombre y apellido de los empleados que pertenecen al departamento de "Recursos Humanos" y han realizado más de 5 ventas.

select e.nombre, e.apellido, count(v.id) 'Cantidad ventas'
from empleados e
inner join departamentos d
    on e.departamento_id = d.id
inner join ventas v    
    on e.id = v.empleado_id 
where d.nombre = "Recursos Humanos"
group by e.nombre, e.apellido
having count(v.id) > 5
order by 3 desc;


--2. Muestra el nombre y apellido de todos los empleados junto con la cantidad total de ventas que han realizado, incluso si no han realizado ventas.


select e.nombre, e.apellido, sum(v.cantidad) 'Cantidad total'
from empleados e
left join ventas v 
    on e.id = v.empleado_id
group by e.nombre, e.apellido;


--3. Encuentra el empleado más joven de cada departamento y muestra el nombre del departamento junto con el nombre y la edad del empleado más joven.


select d.nombre, e.nombre, e.apellido, e.edad
from departamentos d
inner join empleados e
    on e.departamento_id = d.id
inner join(
    select departamento_id, MIN(edad) edad_minima
    from empleados e
    group by departamento_id ) e_min
    on  e.departamento_id =  e_min.departamento_id and
    e.edad  = e_min.edad_minima ;


--4. Calcula el volumen de productos vendidos por cada producto (por ejemplo, menos de 5 como "bajo", entre 5 y 10 como "medio", y más de 10 como "alto") y muestra la categoría de volumen junto con la cantidad y el nombre del producto.


select 
    case   
        when  sum(v.cantidad) >10 then  'Alto'
        when  sum(v.cantidad) >5 then 'Medio'
        else 'Bajo'
    end as Volumen,
    sum(v.cantidad) 'Cantidad Total',
    p.nombre 'Nombre Producto'
from productos p
inner join ventas v
    on p.id = v.producto_id
group by p.nombre
order by  2 desc;

-- Ejercicios Prácticos con Tablas Temporales 

--EJERCICIOS TEÓRICOS

DROP TEMPORARY TABLE IF EXISTS tabla_temporal1;
CREATE TEMPORARY TABLE tabla_temporal1 AS
VALUES ROW(10, 'Alice'), ROW(20, 'Bob'), ROW(30, 'Charlie');

table tabla_temporal1;

DROP TEMPORARY TABLE IF EXISTS tabla_temporal2;
CREATE TEMPORARY TABLE tabla_temporal2 AS
VALUES ROW(20, 'bob'), ROW(15, 'David'), ROW(25, 'Eve');

table tabla_temporal2;

-- alt + shift + flecha abajo

--UNION
table tabla_temporal1 union table tabla_temporal2; 
table tabla_temporal2 union table tabla_temporal1; 

--INTERSECT
table tabla_temporal1 intersect table tabla_temporal2; 
table tabla_temporal2 intersect table tabla_temporal1; 

--EXCEPT
table tabla_temporal1 except table tabla_temporal2; 
table tabla_temporal2 except table tabla_temporal1; 


use mi_bd;

--1. Utiliza TABLE para consultar la tabla productos de manera simple, ordenando los productos de forma descendente por precio y solo 10 filas.

table productos
order by precio asc
limit 10;
--2. Crea una tabla temporal de los empleados donde unifiques su nombre y apellido en una sola columna.

drop temporary table if exists tabla_temporal_empleados;
create temporary table tabla_temporal_empleados AS
select concat(e.nombre, ' ', e.apellido) 'Nombre empleado' from empleados e;

select * from tabla_temporal_empleados;
table tabla_temporal_empleados;

--3. Crea una tabla temporal de la tabla clientes donde solo tengas la columna nombre.

select * from clientes;

drop temporary table if exists tabla_temporal_clientes;
create temporary table tabla_temporal_clientes as
select c.nombre 'Nombre cliente' from clientes c; 

select * from tabla_temporal_clientes;
table tabla_temporal_clientes;

--4. Realiza la unión entre las tablas temporales de empleados y clientes usando TABLE.

table tabla_temporal_empleados 
UNION
table tabla_temporal_clientes;

--5. Crea una tabla temporal escuela primaria que tenga las siguientes columnas: id(int), nombre(varchar), apellido(varchar), edad(int) y grado(int). Y que tenga los siguientes valores:

--ID: 1, Nombre: Alejandro, Apellido: González, Edad: 11, Grado: 5
--ID: 2, Nombre: Isabella, Apellido: López, Edad: 10, Grado: 4
--ID: 3, Nombre: Lucas, Apellido: Martínez, Edad: 11, Grado: 5 
--ID: 4, Nombre: Sofía, Apellido: Rodríguez, Edad: 10, Grado: 4 
--ID: 5, Nombre: Mateo, Apellido: Pérez, Edad: 12, Grado: 6 
--ID: 6, Nombre: Valentina, Apellido: Fernández, Edad: 12, Grado: 6
--ID: 7, Nombre: Diego, Apellido: Torres, Edad: 10, Grado: 4
--ID: 8, Nombre: Martina, Apellido: Gómez, Edad: 11, Grado: 5
--ID: 9, Nombre: Joaquín, Apellido: Hernández, Edad: 10, Grado: 4
--ID: 10, Nombre: Valeria, Apellido: Díaz, Edad: 11, Grado: 5

drop temporary table if exists escuela_primaria;
create temporary table escuela_primaria(
    id int auto_increment primary key,
    nombre varchar(45),
    apellido varchar(45),
    edad int,
    grado int
);

table escuela_primaria;

describe escuela_primaria;
show columns from escuela_primaria;

insert into escuela_primaria(nombre, apellido, edad, grado) values ('Alejandro', 'González', 11, 5);
insert into escuela_primaria(nombre, apellido, edad, grado) values ('Isabella', 'López', 10, 4);
insert into escuela_primaria(nombre, apellido, edad, grado) values ('Lucas', 'Martínez', 11, 5);
insert into escuela_primaria(nombre, apellido, edad, grado) values ('Sofía', 'Rodríguez', 10, 4);
insert into escuela_primaria(nombre, apellido, edad, grado) values ('Mateo', 'Pérez', 12, 6);
insert into escuela_primaria(nombre, apellido, edad, grado) values ('Valentina', 'Fernández', 12, 6);
insert into escuela_primaria(nombre, apellido, edad, grado) values ('Diego', 'Torres', 10, 4);
insert into escuela_primaria(nombre, apellido, edad, grado) values ('Martina', 'Gómez', 11, 5);
insert into escuela_primaria(nombre, apellido, edad, grado) values ('Joaquín', 'Hernández', 10, 4);
insert into escuela_primaria(nombre, apellido, edad, grado) values ('Valeria', 'Díaz', 11, 5);
insert into escuela_primaria(nombre, apellido, edad, grado) values ('valeria', 'Díaz', 11, 5);

select * from escuela_primaria;
table escuela_primaria;



--MySQL: Funciones de Texto



--MySQL: Funciones de Fecha y Hora

-- Ejercicios funciones de  fecha y hora

--1. Crea una tabla llamada "envios" con cuatro columnas: "id" de tipo INT como clave primaria y autoincremental, "fecha_envio" de tipo DATETIME,  "fecha_entrega" de tipo DATETIME y "codigo_producto" de tipo VARCHAR(10). Luego, inserta siete filas en la tabla "envios" con los siguientes datos:

create table envios(
    id int auto_increment primary key,
    fecha_envio datetime,
    fecha_entrega datetime,
    codigo_producto varchar(10)
);

insert into envios (fecha_envio, fecha_entrega, codigo_producto) values ('2022-01-15 08:00:00', '2022-01-20 12:30:00', 'ABC123');
insert into envios (fecha_envio, fecha_entrega, codigo_producto) values ('2022-02-10 10:15:00', '2022-02-15 14:45:00', 'XYZ789');
insert into envios (fecha_envio, fecha_entrega, codigo_producto) values ('2022-03-05 09:30:00', '2022-03-10 13:20:00', 'PQR456');
insert into envios (fecha_envio, fecha_entrega, codigo_producto) values ('2022-04-20 11:45:00', '2022-04-25 15:10:00', 'LMN001');
insert into envios (fecha_envio, fecha_entrega, codigo_producto) values ('2022-05-12 07:55:00', '2022-05-17 10:25:00', 'DEF777');
insert into envios (fecha_envio, fecha_entrega, codigo_producto) values ('2022-06-08 08:20:00', '2022-06-13 12:40:00', 'GHI888');
insert into envios (fecha_envio, fecha_entrega, codigo_producto) values ('2022-07-03 10:05:00', '2022-07-08 14:15:00', 'JKL999');

--2. Utilizando la función DATE_ADD, calcula la fecha de entrega programada para un envío con código de producto 'ABC123' cuando se le añaden 5 días a la fecha de envío.

select e.fecha_entrega , 
    DATE_ADD(e.fecha_entrega, INTERVAL 5 DAY) as "Fecha entrega programada",
    ADDDATE(e.fecha_entrega, 5) as "Fecha entrega programada 2"
from envios e
where e.codigo_producto ='ABC123';

--3. Utilizando la función ADDTIME, encuentra la hora estimada de entrega para un envío con código de producto 'XYZ789' si se suma 4 horas y 30 minutos a la hora de entrega. 

select  e.codigo_producto , e.fecha_entrega , 
ADDTIME(e.fecha_entrega, '04:30:00') as "Fecha de entrega sumada",
TIME(ADDTIME(e.fecha_entrega, '04:30:00')) as "Hora de entrega sumada"
from envios e
where e.codigo_producto ='XYZ789';

--4. Utilizando la función CONVERT_TZ, convierte la fecha de envío de un envío con código de producto 'PQR456' de la zona horaria 'UTC' (+00:00) a la zona horaria de Argentina GMT-3 (-03:00).

select e.codigo_producto,
       e.fecha_envio,
       CONVERT_TZ(e.fecha_envio, '+00:00' , '-03:00' ) as 'Fecha envio Argentina'
from envios e   
where e.codigo_producto = 'PQR456';

--5. Calcula la diferencia en días entre la fecha de entrega y la fecha de envío para el envío con código de producto 'LMN001' utilizando la función DATEDIFF.

select e.codigo_producto,
       e.fecha_entrega,
       e.fecha_envio,
       DATEDIFF(e.fecha_entrega, e.fecha_envio) 'Diferencia'
from envios e   
where e.codigo_producto = 'LMN001';

--6. Utiliza la función CURDATE para obtener la fecha actual y, a continuación, obtener la diferencia en días entre la fecha de entrega con código de producto 'DEF777' y la fecha actual.

select e.codigo_producto,
       e.fecha_entrega,
       CURDATE() as 'Fecha actual',
       DATEDIFF(e.fecha_entrega, CURDATE()) 'Diferencia'
from envios e   
where e.codigo_producto = 'DEF777';

--7. Utilizando la función CURTIME, obtén la hora actual del sistema.

select CURTIME();

--8. Utiliza la función DATE para extraer la fecha de envío del envío con ID 3.

select e.fecha_envio,
    DATE(e.fecha_envio)
from envios e   
where e.id = 3;

--9. Utiliza la función DATE_ADD para calcular la fecha de entrega programada para el envío con código de producto 'XYZ789' si se le agregan 3 días a la fecha de envío.

select e.fecha_entrega , 
    DATE_ADD(e.fecha_entrega, INTERVAL 3 DAY) as "Fecha entrega programada",
    ADDDATE(e.fecha_entrega, 5) as "Fecha entrega programada 2"
from envios e
where e.codigo_producto ='XYZ789';

--10. Utiliza la función DATE_FORMAT para mostrar la fecha de envío del envío con ID 6 en el formato 'DD-MM-YYYY'.

select e.fecha_envio,
    DATE_FORMAT(e.fecha_envio, '%d-%m-%Y')
from envios e   
where e.id = 6;

--11. Utiliza la función DATE_SUB para calcular la fecha de envío del envío con ID 4 si se le restan 2 días.

select e.fecha_envio, DATE_SUB(e.fecha_envio, INTERVAL 2 DAY) as 'Fecha envio 2 dias antes'
from envios e
where e.id = 4;

--12. Utiliza la función DATEDIFF para calcular la diferencia en días entre la fecha de envío y la fecha de entrega programada para el envío con código de producto 'PQR456'.

select e.fecha_envio, e.fecha_entrega, DATEDIFF(e.fecha_envio, e.fecha_entrega) 'Diferencia'
from envios e
where e.codigo_producto = 'PQR456'

--13. Utiliza la función DAY para obtener el día del mes en que se realizó el envío con ID 2.

select  e.fecha_envio, 
        day(e.fecha_envio) 'Dia mes envío'
from envios e
where e.id = 2;

--14. Utiliza la función DAYNAME para obtener el nombre del día de la semana en que se entregará el envío con código de producto 'DEF777'.

SET lc_time_names = 'es_PE';

select  e.fecha_entrega,
        dayname(e.fecha_entrega) as 'Dia de la semana de entrega'
from envios e
where e.codigo_producto = 'DEF777';

--15. Utiliza la función DAYOFMONTH para obtener el día del mes en que se entregará el envío con código de producto 'GHI888'.

select  e.fecha_entrega,
        DAYOFMONTH(e.fecha_entrega) as 'Día del mes de entrega'
from envios e
where e.codigo_producto = 'GHI888'


--Funciones de fecha y hora avanzadas


-- 16. Utiliza la función PERIOD_ADD para agregar un período de 3 meses al año-mes '2022-07'.

select period_add('202207', 3);

-- 17. Utiliza la función PERIOD_DIFF para calcular el número de meses entre los períodos '2022-03' y '2022-12'.

select period_diff('202203', '202212') as 'Diferencia meses';

-- 18. Utiliza la función QUARTER para obtener el trimestre de la fecha de entrega del envío con código de producto 'PQR456'.

select e.fecha_entrega,
       quarter(e.fecha_entrega) as 'Trimestre de entrega'
from envios e
where e.codigo_producto = 'PQR456';

-- 19. Utiliza la función SEC_TO_TIME para convertir 3665 segundos en formato 'hh:mm:ss'.

select sec_to_time(3365) 'HH:MM:SS';

-- 20. Utiliza la función SECOND para obtener los segundos de la hora de envío del envío con ID 2.

select  e.fecha_envio,
        SECOND(e.fecha_envio) as 'Segundos hora envio'
from envios e
where e.id = 2;

-- 21. Utiliza la función STR_TO_DATE para convertir la cadena '2022()08()15' en una fecha.

select str_to_date('2022()08()15', '%Y()%m()%d') as 'Fecha';

-- 22. Utiliza la función SUBDATE (o DATE_SUB) para restar 5 días a la fecha de entrega del envío con código de producto 'GHI888'.

select  e.fecha_entrega,
        date_sub(e.fecha_entrega, interval 5 day) 'Fecha entrega nueva'
from envios e
where e.codigo_producto = 'GHI888';

-- 23. Utiliza la función SUBTIME para restar 2 horas y 15 minutos a la hora de envío del envío con ID 7.

select  e.fecha_envio,
        SUBTIME(e.fecha_envio, '02:15:00') as 'Hora envio nueva'
from envios e
where e.id = 7;

-- 24. Utiliza la función TIME para extraer la porción de tiempo de la fecha de envío del envío con ID 1.

select  e.fecha_envio,
        TIME(e.fecha_envio) as 'Time'
from envios e
where e.id = 1;

-- 25. Utiliza la función TIME_FORMAT para formatear la hora de envío del envío con ID 2 en 'hh:mm:ss'.

select  e.fecha_envio,
        TIME_FORMAT(e.fecha_envio, '%T') 'Nuevo formato'
from envios e
where e.id =2;

-- 26. Utiliza la función TIME_TO_SEC para convertir la hora de envío del envío con ID 3 en segundos.

select  e.fecha_envio,
        TIME_TO_SEC(TIME(e.fecha_envio)) 'Tiempo en segundos'
from envios e
where e.id =3;

-- 27. Utiliza la función TIMEDIFF para calcular la diferencia de horas entre las fechas de envío y entrega del envío con ID 4.

select  e.fecha_envio,
        e.fecha_entrega,
        TIMEDIFF(e.fecha_envio, e.fecha_entrega) 'Diferencia'
from envios e
where e.id =4;

-- 28. Utiliza la función SYSDATE para obtener la hora exacta en la que se ejecuta la función en la consulta. Para comprobar esto invoca SYSDATE, luego la función SLEEP durante 5 segundos y luego vuelve a invocar la función SYSDATE, y verifica la diferencia entre ambas invocaciones con TIMEDIFF.

SELECT TIMEDIFF(hora_final, hora_inicial) AS diferencia_de_hora FROM
( SELECT
SYSDATE() AS hora_inicial,
SLEEP(5),
SYSDATE() AS hora_final) t;

-- 29. Crea una consulta que utilice la función TIMESTAMP para obtener todos los valores de fecha_envio sumandole 12 horas.

select  e.id,
        e.fecha_entrega,
        e.fecha_envio,
        timestamp(e.fecha_envio, '12:00:00') as 'Fecha envio nueva'
from envios e;

-- 30. Utiliza la función TIMESTAMPADD para agregar 3 horas a la fecha de entrega del envío con código de producto 'XYZ789'.

select  e.fecha_envio,
        timestampadd(HOUR, 3 , e.fecha_envio) as 'Fecha envio nueva'
from envios e
where e.codigo_producto = 'XYZ789';


--Ejercicios vistas y funciones matemáticas

--1. Crea una tabla triangulos_rectangulos con dos columnas: longitud_lado_adyacente y longitud lado_opuesto, ambos de tipo INT.

use mi_bd;
show tables;

create table triangulos_rectangulos (
    longitud_lado_adyacente int,
    longitud_lado_opuesto int
);

describe triangulos_rectangulos;
show columns from triangulos_rectangulos;

--2. Rellena la tabla triangulos_rectangulos con 10 filas con enteros aleatorios entre 1 y 100

-- i<=R<j - > FLOOR(i + rand()*(j-i) ),  i=1, j=100
--revisar conceptos de floor(x), ceil(x)

--copiar fila actual haci abajo : shift + alt + flecha abajo

insert into triangulos_rectangulos (longitud_lado_adyacente, longitud_lado_opuesto)
values 
        ( FLOOR(1 + RAND()*99) ,   FLOOR(1 + RAND()*99)    ),
        ( FLOOR(1 + RAND()*99) ,   FLOOR(1 + RAND()*99)    ),
        ( FLOOR(1 + RAND()*99) ,   FLOOR(1 + RAND()*99)    ),
        ( FLOOR(1 + RAND()*99) ,   FLOOR(1 + RAND()*99)    ),
        ( FLOOR(1 + RAND()*99) ,   FLOOR(1 + RAND()*99)    ),
        ( FLOOR(1 + RAND()*99) ,   FLOOR(1 + RAND()*99)    ),
        ( FLOOR(1 + RAND()*99) ,   FLOOR(1 + RAND()*99)    ),
        ( FLOOR(1 + RAND()*99) ,   FLOOR(1 + RAND()*99)    ),
        ( FLOOR(1 + RAND()*99) ,   FLOOR(1 + RAND()*99)    ),
        ( FLOOR(1 + RAND()*99) ,   FLOOR(1 + RAND()*99)    );

select * from triangulos_rectangulos;
table triangulos_rectangulos;

--3. Crea una vista donde agregues la columna “hipotenusa” calculándola a partir de los otros dos lados. Utiliza el teorema de Pitágoras para realizar el cálculo: Siendo el lado adyacente “A” y el opuesto “B” y la hipotenusa “C” la fórmula quedaría de la siguiente forma:
--C = SQRT(A^2 + B^2)​

CREATE OR REPLACE VIEW vista_triangulos AS
SELECT  t.longitud_lado_adyacente,
        t.longitud_lado_opuesto,
        SQRT( POW(t.longitud_lado_adyacente , 2) +  POW(t.longitud_lado_opuesto,2)) as 'Hipotenusa'
from triangulos_rectangulos t;

select * from vista_triangulos;
table vista_triangulos;


--4. Reemplaza la vista y ahora agrégale dos columnas para calcular el ángulo α en radianes y grados. Aquí tienes dos fórmulas:
--En radianes: = arcsen(B/C) = arccos(A/C) = arctan(B/A)

CREATE OR REPLACE VIEW vista_triangulos AS
SELECT  t.longitud_lado_adyacente, --A
        t.longitud_lado_opuesto, --B
        SQRT( POW(t.longitud_lado_adyacente , 2) +  POW(t.longitud_lado_opuesto,2)) as 'Hipotenusa',
        ATAN(t.longitud_lado_opuesto / t.longitud_lado_adyacente) as 'Angulo alfa en radianes',
        DEGREES(ATAN(t.longitud_lado_opuesto / t.longitud_lado_adyacente)) as 'Angulo alfa en grados'
from triangulos_rectangulos t;


table vista_triangulos ;
select * from vista_triangulos order by 1;

--5. Reemplaza la vista y ahora agrégale dos columnas para calcular el ángulo β en radianes y grados. Aquí tienes dos fórmulas:
--En radianes: β = arccos(B/C)=arcsen(A/C) = arctan(A/B)  


CREATE OR REPLACE VIEW vista_triangulos AS
SELECT  t.longitud_lado_adyacente, 
        t.longitud_lado_opuesto, 
        SQRT( POW(t.longitud_lado_adyacente , 2) +  POW(t.longitud_lado_opuesto,2)) as 'Hipotenusa',
        ATAN(t.longitud_lado_opuesto / t.longitud_lado_adyacente) as angulo_alfa_radianes,
        DEGREES(ATAN(t.longitud_lado_opuesto / t.longitud_lado_adyacente)) as angulo_alfa_grados,
        ATAN(t.longitud_lado_adyacente / t.longitud_lado_opuesto) as angulo_beta_radianes,
        DEGREES(ATAN(t.longitud_lado_adyacente / t.longitud_lado_opuesto)) as angulo_beta_grados
from triangulos_rectangulos t;

table vista_triangulos ;

select *, angulo_alfa_grados + angulo_beta_grados as 'Suma alfa y beta'
from vista_triangulos;

--6. Reemplaza la vista y ahora agrégale dos columnas para calcular el ángulo γ en radianes y grados. Como se trata de triángulos rectángulos, el ángulo es de 90°, pero aplica una fórmula de igual manera, usa la regla de que la suma de los ángulos de un triángulo suma 180°.

-- Se debe tener en cuenta que PI radianes = 180° 

show databases;
use mi_bd;

CREATE OR REPLACE VIEW vista_triangulos AS
SELECT  t_aux.angulo_alfa_grados,
        t_aux.angulo_beta_grados,
        (PI() - t_aux.angulo_alfa_radianes - t_aux.angulo_beta_radianes) as angulo_gamma_radianes,
        DEGREES(PI() - t_aux.angulo_alfa_radianes - t_aux.angulo_beta_radianes) as angulo_gamma_grados
FROM 
    (   SELECT  t.longitud_lado_adyacente as a, 
                t.longitud_lado_opuesto as b, 
                SQRT( POW(t.longitud_lado_adyacente , 2) +  POW(t.longitud_lado_opuesto,2)) as c ,
                ATAN(t.longitud_lado_opuesto / t.longitud_lado_adyacente) as angulo_alfa_radianes,
                DEGREES(ATAN(t.longitud_lado_opuesto / t.longitud_lado_adyacente)) as angulo_alfa_grados,
                ATAN(t.longitud_lado_adyacente / t.longitud_lado_opuesto) as angulo_beta_radianes,
                DEGREES(ATAN(t.longitud_lado_adyacente / t.longitud_lado_opuesto)) as angulo_beta_grados
        from triangulos_rectangulos t ) as t_aux;

select * from vista_triangulos;

--7. Crea una tabla triangulos_rectangulos_2 con dos columnas: angulo_alfa y una hipotenusa ambos de tipo INT.

create table triangulos_rectangulos_2(
    angulo_alfa int,
    hipotenusa int
);

use mi_bd;

describe triangulos_rectangulos_2;

--8. Rellena la tabla triangulos_rectangulos_2 con 10 filas con enteros aleatorios entre 1 y 89 para angulo_alfa y enteros aleatorios entre 1 y 100 para la columna hipotenusa.

insert into triangulos_rectangulos_2 (angulo_alfa, hipotenusa)
values
    ( floor(1 + rand()*88) , floor(1+ rand()*99) ),
    ( floor(1 + rand()*88) , floor(1+ rand()*99) ),
    ( floor(1 + rand()*88) , floor(1+ rand()*99) ),
    ( floor(1 + rand()*88) , floor(1+ rand()*99) ),
    ( floor(1 + rand()*88) , floor(1+ rand()*99) ),
    ( floor(1 + rand()*88) , floor(1+ rand()*99) ),
    ( floor(1 + rand()*88) , floor(1+ rand()*99) ),
    ( floor(1 + rand()*88) , floor(1+ rand()*99) ),
    ( floor(1 + rand()*88) , floor(1+ rand()*99) ),
    ( floor(1 + rand()*88) , floor(1+ rand()*99) )
;

select * from triangulos_rectangulos_2;
table triangulos_rectangulos_2;

--9. Crea una vista donde agregues la columna lado_adyacente donde calcules su longitud.

--consideraciones: 
--9.1: angulo_alfa se encuentra en grados (°), angulo_beta (180° - angulo_alfa - 90°), angulo_gamma = 90°
--9.2: Siendo el lado adyacente “A” y el opuesto “B” y la hipotenusa “C”.  C = SQRT(A^2 + B^2 )
--9.3: En radianes: α = arcsen(B/C) = arccos(A/C) = arctan(B/A)  
--9.4: En radianes angulo_alfa_rad: RADIANS( angulo_alfa °)

-- A partir de 9.3 se usará la siguiente fórmula: α = arccos(A/C) 
-- Esto es quivalente a: angulo_alfa_rad = arccos(lado_adyacente / hipotenusa )
-- Se desea obtener el lado adyacente (A) y por lo tanto se debe despejar de la formula
-- Se aplica el coseno a ambos lados: cos(angulo_alfa_rad) = cos(arccos (lado_adyacente / hipotenusa))
-- cos(angulo_alfa_rad) =  lado_adyacente / hipotenusa
-- Despejando el lado adyacente:  cos(angulo_alfa_rad)*hipotenusa = lado_adyacente
-- lado_adyacente = cos(angulo_alfa_rad) * hipotenusa;
-- lado_adyacente = cos(RADIANS(angulo_alfa))*hipotenusa;

describe triangulos_rectangulos_2;

create or replace view vista_triangulos_2 as
select  t.angulo_alfa,
        t.hipotenusa,
        (cos(RADIANS(t.angulo_alfa))*t.hipotenusa) as lado_adyacente

from triangulos_rectangulos_2 t;

select * from vista_triangulos_2;

--10. Agrega a la vista la columna lado_opuesto donde calcules su longitud.

--consideraciones: 
--10.1: angulo_alfa se encuentra en grados (°), angulo_beta (180° - angulo_alfa - 90°), angulo_gamma = 90°
--10.2: Siendo el lado adyacente “A” y el opuesto “B” y la hipotenusa “C”.  C = SQRT(A^2 + B^2 )
--10.3: En radianes: α = arcsen(B/C) = arccos(A/C) = arctan(B/A)  
--10.4: En radianes angulo_alfa_rad: RADIANS( angulo_alfa °)

-- A partir de 10.3 se usará la siguiente fórmula: α = arcsen(B/C) 
-- Esto es quivalente a: angulo_alfa_rad = arcsen(lado_opuesto / hipotenusa )
-- Se desea obtener el lado opuesto (B) y por lo tanto se debe despejar de la formula
-- Se aplica el seno a ambos lados: sen(angulo_alfa_rad) = sen(arcsen (lado_opuesto / hipotenusa))
-- sen(angulo_alfa_rad) =  lado_opuesto / hipotenusa
-- Despejando el lado opuesto:  sen(angulo_alfa_rad)*hipotenusa = lado_opuesto
-- lado_opuesto = sen(angulo_alfa_rad) * hipotenusa;
-- lado_opuesto = sen(RADIANS(angulo_alfa))*hipotenusa;


create or replace view vista_triangulos_2 as
select  t.angulo_alfa,
        t.hipotenusa,
        (cos(RADIANS(t.angulo_alfa))*t.hipotenusa) as lado_adyacente,
        (sin(RADIANS(t.angulo_alfa))*t.hipotenusa) as lado_opuesto

from triangulos_rectangulos_2 t;

select * from vista_triangulos_2;


--11. Agrega a la vista la columna angulo_beta donde calcules su valor en grados.
--consideraciones:
--11.1: En radianes: β = arccos(B/C)= arcsen(A/C) = arctan(A/B) 
--11.2: Siendo el lado adyacente “A” y el opuesto “B” y la hipotenusa “C”.  C = SQRT(A^2 + B^2 ) 
--> formular a usar: β = arccos(B/C)
--> angulo_beta_rad = arccos(lado_opuesto/hipotenusa)
--> angulo_beta ° = DEGREES(arccos(lado_opuesto/hipotenusa));

create or replace view vista_triangulos_2 as
select  t_aux.angulo_alfa,
        DEGREES(acos(t_aux.lado_opuesto/hipotenusa)) as angulo_beta
from(
    select  t.angulo_alfa,
            t.hipotenusa,
            (cos(RADIANS(t.angulo_alfa))*t.hipotenusa) as lado_adyacente,
            (sin(RADIANS(t.angulo_alfa))*t.hipotenusa) as lado_opuesto
    from triangulos_rectangulos_2 t ) t_aux;

select * from vista_triangulos_2;


--12. Agrega a la vista la columna angulo_gamma donde calcules su valor en grados.

--consideraciones:
--12.1: En grados: 90° (angulo gamma) + alfa° + beta ° = 180 °
--12:2: En radianes: pi/2 + alfa (rad) + beta (rad) = pi 

create or replace view vista_triangulos_2 as
select  t_aux_2.angulo_alfa,
        t_aux_2.angulo_beta,
        (180 - t_aux_2.angulo_alfa - t_aux_2.angulo_beta) as angulo_gamma 
from (
    select  t_aux.angulo_alfa,
            DEGREES(acos(t_aux.lado_opuesto/hipotenusa)) as angulo_beta
    from (
        select  t.angulo_alfa,
                t.hipotenusa,
                cos(RADIANS(t.angulo_alfa))*t.hipotenusa as lado_adyacente,
                sin(RADIANS(t.angulo_alfa))*t.hipotenusa as lado_opuesto
        from triangulos_rectangulos_2 t 
    ) t_aux
) t_aux_2;

select * from vista_triangulos_2;    

--13. Redondea todos los valores con hasta dos números decimales.

create or replace view vista_triangulos_2 as
select  t_aux_2.angulo_alfa,
        t_aux_2.angulo_beta,
        round(180 - t_aux_2.angulo_alfa - t_aux_2.angulo_beta, 2) as angulo_gamma 
from (
    select  t_aux.angulo_alfa,
            round(DEGREES(acos(t_aux.lado_opuesto/hipotenusa)),2) as angulo_beta
    from(
        select  t.angulo_alfa,
                t.hipotenusa,
                round(cos(RADIANS(t.angulo_alfa))*t.hipotenusa , 2) as lado_adyacente,
                round(sin(RADIANS(t.angulo_alfa))*t.hipotenusa , 2) as lado_opuesto
        from triangulos_rectangulos_2 t 
    ) t_aux
) t_aux_2;

select * from vista_triangulos_2;   