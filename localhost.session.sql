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

ALTER TABLE empleados MODIFY COLUMN edad INT NOT NULL;

ALTER TABLE empleados MODIFY column salario INT default 0;

alter table empleados add column departamento varchar(50);

alter table empleados add column correo_electronico varchar(100);

alter table empleados drop column fecha_contratacion;

alter table empleados add column fecha_contratacion date  default (current_date);

create table departamentos(
id int auto_increment primary key,
nombre varchar(50)
);

alter table empleados add column departamento_id int;

alter table empleados
add foreign key (departamento_id) references
departamentos(id);


alter table empleados 
drop column departamento;
