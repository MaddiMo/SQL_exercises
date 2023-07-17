##########################################################
##########################################################
# Nota ejecutar las 2 siguientes líneas para evitar el error 1055
SELECT @@sql_mode; 
	# "@@" para definir una variable
SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
	# quitar error 1055
-- Uniones SQL 

##########################################################
##########################################################

/* Si ya tienes configurada la tabla 'departments_dup', 
utilice DROP COLUMN para eliminar la columna 'dept_manager' 
de la tabla 'departments_dup'.

/*Si ya tienes configurada la tabla 'departments_dup', 
utilice DROP COLUMN para eliminar la columna 'dept_manager' 
de la tabla 'departments_dup'.*/

alter table departments_dup drop dept_manager;

# A continuación, utiliza CHANGE COLUMN para cambiar 
# las columnas "dept_no" y "dept_name" a NULL.

alter table departments_dup 
change column dept_no dept_no VARCHAR(4);

alter table departments_dup change column dept_name dept_name VARCHAR(40);

/* Si no tienes configurada la tabla "departments_dup", créala. 
Que contenga dos columnas: dept_no y dept_name. 
Que el tipo de datos de dept_no sea CHAR de 4, y 
el tipo de datos de dept_name sea VARCHAR de 40. 
Ambas columnas pueden tener valores nulos. 
Finalmente, inserta la información contenida en 
'departments' en 'departments_dup. */

insert into departments_dup select * from departments;

/*A continuación, inserta un registro cuyo nombre de 
departamento sea "Public Relations".*/

insert into departments_dup (dept_name) values ("Public Relations");

/*Elimina el registro o registros relacionados con el 
departamento número dos (d002).*/

delete from departments_dup where dept_no = "d002";

/*Inserta dos nuevos registros en la tabla "departments_dup". 
Que sus valores en la columna "dept_no" sean "d010" y "d011".*/

insert into departments_dup (dept_no) values ("d010");
insert into departments_dup (dept_no) values ("d011");

# OR insert into departments_dup (dept_no) values ("d010")("d011");

delete from departments_dup where dept_no = "d010" AND dept_name = "Business Analysis";

select * from departments_dup order by dept_no ASC;

/* Crea y rellena la tabla 'dept_manager_dup', utilizando el siguiente código: */

DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );

INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES  (999904, '2017-01-01'),
		(999905, '2017-01-01'),
        (999906, '2017-01-01'),
       	(999907, '2017-01-01');

DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001'; 
    
INSERT INTO departments_dup (dept_name) 
VALUES 	('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';

/* Ejecuta las 2 siguientes querys y analiza el 
resultado */

-- departments_manager_dup
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;

-- departments_dup
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

/* Ejecuta el código siguiente generar una query para
hacer un join entre 2 tablas extrayendo únicamente
los registros comumes a ambas y las columnas 
dept_no, emp_no y dept_name. 
Estudia el ejemplo y la clave usada para hacer
el join en ON.
Si no le indicamos nada SQL genera joins de tipo INNER
aunque sólo indiquemos que queremos un JOIN
*/

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

/*  Ahora extrae una lista con información sobre 
el número de empleado, nombre y apellidos, 
número de departamento y fecha de contratación 
de todos los managers. */

SELECT 
    e.emp_no, e.first_name, e.last_name, dm.from_date
FROM
    employees AS e
        INNER JOIN
    dept_manager AS dm ON e.emp_no = dm.emp_no
ORDER BY emp_no;

    
    /* Crea una INNER JOIN que muestre las columnas:
    dept_no, emp_no, from_date y to_date de la tabla 
    dept_manager_dup y la columna dept_name de departments_dup
    Ordena el resultado por la columna dept_no de la
    tabla dept_manager_dup */

SELECT 
    dm.dept_no, dm.emp_no, dm.to_date, d.dept_name
FROM
    dept_manager AS dm
        INNER JOIN
    departments_dup d ON dm.dept_no = d.dept_no
ORDER BY dm.dept_no;

/* Comprueba el resultado si le das la vuelta a la igualdad
en el ON (compara ahora la clave de departments_dup dept_no
contra la clave dept_no de dept_manager_dup */



###########
-- Registros duplicados
###########  

-- Añade los siguientes registros a los datos
INSERT INTO dept_manager_dup 
VALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');
        
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service');

-- Comprueba lo añadido a través del siguiente código

SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no ASC;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC;

/* Habrás visto que tenemos registros duplicados en las tablas.
Ejecuta ahora un inner join con las tablas
dept_manager y departments_dup a través de dept_no
agrupando los datos por emp_no y ordenando por dept_no */

SELECT 
    dm.*
FROM
    dept_manager AS dm
        INNER JOIN
    departments_dup dd ON dm.dept_no = dd.dept_no
GROUP BY dm.emp_no
ORDER BY dm.dept_no asc;

/* Comprueba qué pasa si no agrupas los datos.
¿Tienes más o menos registros que antes? */

select * from departments_dup;
select * from dept_manager;

/* Elimina los registros duplicados que hemos añadido al
inicio de la sección mediante la instrucción DELETE FROM */

select distinct * from departments_dup;

	# CREAR UNA NUEVA TABLA CON TUTTO DE departments_dup2, y luego hacer una comparacion. 
CREATE TABLE departments_dup2 (
    dept_no VARCHAR(255) NULL,
    dept_name VARCHAR(255) NULL
);
insert into deparments_dup2 (dept_no, dept_name) select * from departments_dup group by dept_no;
select * from departments_dup group by dept_no;

delete from dept_manager_dup where from_date = '1992-03-21';
delete from departments_dup where dept_no = 'd009' and dept_name = 'Customer Service';

/* Ahora que los has borrado, restáuralos de nuevo.
Los vamos a usar más adelante.
Básicamente ejecuta las lineas de código del inicio
de la seccVALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');
        
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service')ión
 */

INSERT INTO dept_manager_dup 
VALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');
        
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service');

/* Ejecuta una LEFT join entre 
-- 1) departments y dept_manager, mostrando las columnas dept_no, emp_no, dept_name.  
Usa dept_no como clave para la unión y ordena el resultado por dept_no de la tabla dept_manager_dup.  Deberías obtener 25 registros
-- 2) Misma consulta que la anterior, muestra primero la columna dept_no de departments_dup, el resto de columnas igual,
Ordena el resultado por dept_no de departments_dup. Deberías obtener 25 registros
-- 3) Ejecuta una consulta LEFT OUTER entre departments_dup y dept_manager, mostrando las mismas columnas
que en el punto anterior, mismas claves y mismo criterio de ordenación. Deberías obtener 25 registros
*/

SELECT 
	dd.dept_no, dd.dept_name, dm.emp_no
FROM
    departments as dd
        LEFT JOIN
    dept_manager AS dm ON dd.dept_no = dm.dept_no
ORDER BY dm.dept_no;

# -- 2) Misma consulta que la anterior, tabla departments, muestra primero la columna dept_no de departments_dup, el resto de columnas igual,
# Ordena el resultado por dept_no de departments_dup. Deberías obtener 25 registros

SELECT 
	dd.dept_no, dm.emp_no, dd.dept_name
FROM
    departments as dd
        LEFT JOIN
    dept_manager AS dm ON dd.dept_no = dm.dept_no
ORDER BY dd.dept_no;

# -- 3) Ejecuta una consulta LEFT OUTER entre departments y dept_manager, mostrando las mismas columnas
# que en el punto anterior, mismas claves y mismo criterio de ordenación. Deberías obtener 25 registros

SELECT 
    dd.dept_no, dm.emp_no, dd.dept_name
FROM
    departments AS dd
        LEFT JOIN
    dept_manager AS dm ON dd.dept_no = dm.dept_no
WHERE
    dm.dept_no IS NULL
ORDER BY dd.dept_no;

/* Estudia este código
Podemos extraer un join y quedarnos sólo con los registros 
que cumplan una condición
 */

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
WHERE
    dept_name IS NULL
ORDER BY m.dept_no;

/* Ahora une las tablas 'employees' y 'dept_manager' (LEFT JOIN) para obtener un 
subconjunto de todos los empleados cuyo apellido (last_name) sea Markovitch. 
Compruebe si la salida contiene un manager con ese apellido.  

Sugerencia: Crea una salida que contenga la información correspondiente a 
los siguientes campos: 'emp_no', 'first_name', 'last_name', 'dept_no', 'from_date'. 
Ordena por 'dept_no' de forma descendente y, a continuación, por 'emp_no'. */

SELECT 
    e.*
FROM
    employees AS e
        left JOIN
    dept_manager AS dm ON e.emp_no = dm.emp_no
WHERE
    e.last_name = 'Markovitch';
    
/* Basándote en el caso anterior, extrae ahora aquellos employees
cuya fecha de contratación (hire_date) sea previa al 31-01-1985.
Luego ordena el resultado por el número de empleado.
*/

SELECT 
    e.*
FROM
    employees AS e
        left JOIN
    dept_manager AS dm ON e.emp_no = dm.emp_no
WHERE
    e.hire_date <= '1985-01-31'
order by e.emp_no;


/* Une las tablas 'dept_manager_dup' y 'departments_dup' (RIGHT JOIN) para obtener un 
subconjunto de todos los empleados cuya salida que contenga la información correspondiente a 
los siguientes campos: 'dept_no', 'emp_no', 'dept_name. 
Ordena por 'dept_no' */

SELECT 
    dmp.dept_no, dmp.emp_no, dd.dept_name
FROM
    dept_manager_dup AS dmp
        RIGHT JOIN
    departments_dup AS dd ON dmp.dept_no = dd.dept_no
ORDER BY dmp.dept_no;

/* Une las tablas 'employees' y 'titles' (INNER JOIN) para obtener un 
subconjunto de todos los empleados cuya salida que contenga la información correspondiente a 
los siguientes campos: 'first_name', 'last_name', 'hire_date', 'title'.
Filtra el resultado para aquellos casos donde el 'first_name' sea 'Margareta'
y el 'last_name' sea 'Markovitch'
Ordena por 'emp_no' */

SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees AS e
        INNER JOIN
    titles AS t ON e.emp_no = t.emp_no
WHERE
    e.first_name = 'Margareta'
        AND e.last_name = 'Markovitch'
ORDER BY e.emp_no;


/* Ejecuta el siguiente código para evitar el error 1055 en los siguientes casos */
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

###########
-- CROSS JOINS
###########  

/* Analiza el siguiente caso de CROSS JOIN
Cross join devuelve el producto cartesiano de la
unión de 2 tablas. */

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- misma manera de obtener el resultado
SELECT 
    dm.*, d.*
FROM
    dept_manager dm,
    departments d
ORDER BY dm.emp_no , d.dept_no;

/* Extrae el producto cartesiano de las tablas 'departments'
y 'dept_manager' cuya salida que contenga la información correspondiente a 
todos los campos de ambas, pero para aquellos casos donde 
el 'dept_no' sea 'd009'
Ordena por 'dept_name' */

SELECT 
    d.*, dm.*
FROM
    departments AS d
        CROSS JOIN
    dept_manager AS dm
WHERE
    dm.dept_no = 'd009'
ORDER BY d.dept_name;


###########
-- Agregaciones en joins
###########  

/* Estudia este ejemplo 
Obtenemos la media de salario para hombres y mujeres
*/

SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;   

SELECT 
    e.gender, round(AVG(s.salary),2) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender; 

/* Ojo con realizar este tipo de agregación.
Sql nos devuelve por defecto el primer elemento
que encuentre para una clase y no es lo que queremos.
En este caso incluir el emp_no no nos aporta y deberíamos
incluirlo.
*/
SELECT 
    e.emp_no, e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender; 


SELECT 
    d.dept_name, AVG(salary) as average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name;

###########
-- Uniones de 2 o más tablas
###########  

/* Podemos unir 2 ó más tablas, simplemente concatenando joins */

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
;

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    departments d
        RIGHT JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    employees e ON m.emp_no = e.emp_no;
    
/* Selecciona aquellos registros que 
sean managers y extrae su 'first_name',
'last_name', 'hire_date', 'title', 'from_date',
'dept_name'
Ordena el resultado por 'emp_no'
*/

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name,
    t.title
FROM
    dept_manager dm
        JOIN
    titles t ON dm.emp_no = t.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    t.title = 'Manager'
ORDER BY dm.emp_no;




SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.from_date,
    d.dept_name,
    t.title
FROM
    dept_manager AS dm
        JOIN
    employees AS e ON dm.emp_no = e.emp_no
        JOIN
    departments AS d ON dm.dept_no = d.dept_no
        JOIN
    titles AS t ON dm.emp_no = d.emp_no
ORDER BY dm.emp_no;


/* Ahora que sabemos realizar joins con más de 2 tablas,
extrae el salario medio de cada departamento
La información está relacionada a través de 3 tablas
*/



/* Basándote en el caso anterior, modifícalo para
obtener el resultado ordenado por 'dept_no'.
Asigna un alias a la media del salario para que la columna
que contiene el salario agregado no muestre AVG(salary) */



/* Basándote en el caso anterior, modifícalo para
obtener el resultado agrupado por 'dept_name' de manera 
que se muestren sólo los departamentos cuyo salario medio
sea superior a 60000.  Ordena los resultados de manera 
descencente */



/* Ahora extrae los departamentos en los que cada manager
no es manager.
Tendrás que hacer un cross join entre departments y dept_manager
para luego ejecutar un inner con employees.
Ordena el resultado por emp_no y dept_no.
Deberías obtener 216 registros.
*/



/* ¿Cuántos managers mujeres y hombres tenemos en la BBDD employees? */



##########################################################
##########################################################

-- Subconsultas

##########################################################
##########################################################  

/* Comprueba como en estos 3 casos estamos obteniendo el mismo resultado (total de registros)
pero de diferente manera */

SELECT 
    *
FROM
    dept_manager;
 
-- aquí usamos IN para filtra los empleados, pero el IN 
-- se alimenta a su vez de un SELECT 
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
            
SELECT 
    dm.emp_no
FROM
    dept_manager dm;
    
/* A través de una consulta con subconsultas, extrae aquellos
empleados que fueron contratados entre el 01-01-1990 y el 01-01-1995
Parte de la tabla dept_manager y genera la subconsulta que necesites
para obtener el resultado.
Deberías obtener 2 registros.
*/

    

/*
El objetivo es extraer una nueva tabla que contenga para los empleados (emp_no) de employees
menores o iguales a 10020 su emp_no, el departamento al que pertenecen.  A todos estos
registros asociarlos al manager 110022.  A su vez, para los 10 primeros emp_no mayores de 10020
extraer una tabla similar pero asociándolos al manager 110039.

Es un ejemplo un poco más elaborado que los anteriores.  Intenta entender el código de cada parte.

Tabla objetivo que buscamos construir.

employee_id, departament_code, manager_id
10001		 d005			   110022
10002		 d007			   110022
10003		 d004			   110022
...
10021		 d005			   110039
10022		 d005			   110039
10023		 d005			   110039
10024		 d004			   110039

Para obtener esta tabla necesitamos de varias partes. La primera extraer el dato de manager_id
*/
SELECT 
    emp_no
FROM
    dept_manager
WHERE
    emp_no = 110022;
/*
Éste será el dato a usar en la tercera columna de la tabla.  Ahora necesitamos obtener el dato del employee_id y 
el department_code
Puesto que un trabajador puede pertenecer a varios departamentos, vamos a coger aquel número de departamento
más bajo, de todos a los que pueda pertenecer el cada empleado (criterio tomado porque yo he querido, 
coger el más alto también podría valer).
Tendremos que cruzar esta información con la tabla dept_emp a través de emp_no y asegurarnos de que el cruce
se lleva a cabo en aquellos emp_no <=10020
*/

SELECT 
    e.emp_no AS employee_id,
    MIN(de.dept_no) AS department_code,
    (SELECT 									-- Aquí estamos usando un select para construir una 
            emp_no								-- columna al vuelo
        FROM
            dept_manager
        WHERE
            emp_no = 110022) AS manager_id
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no <= 10020
GROUP BY e.emp_no
ORDER BY e.emp_no
;

/*
Con ésto, obtenemos 20 registros como esperábamos del 10001 al 10020.  Pero sólo es la primera
parte de la tabla.
Todo este código lo podemos agrupar bajo el alias A, que usaremos un poco más adelante.
*/
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A
;

/*
Vemos que hace lo mismo que el código anterior, sólo que ahora tenemos un alias A.  
Pero nos permite aprovechar el código para la segunda parte de la tabla
donde el manager debe ser 110039 y los emp_no > 10020 pero cogiendo sólo 20 emp_no
Copio el código y modifico un par de cosas
*/
SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 10) AS B
;
 /*
 Obtenemos otros 10 registros.  Casi lo tenemos.  Ahora tenemos 2 alias, A y B pero debemos 
 unirlos en una sola tabla.  Para ello usamos UNION
 */
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 10) AS B
;

/* Ejecutando el código anterior, tenemos nuestra tabla con 30 registros y las columnas que 
queríamos.
Revisa el código y fíjate cómo hemos usado SELECT para construir una columna y a su vez dentro
de FROM.  Básicamente hemos construído al vuelo la tabla que alimentará el FROM
*/

/* Crea una tabla llamada emp_manager que contenga 3 columnas:
	emp_no con datos de tipo INTEGER(11), y que no acepte nulos
    dept_no con datos de tipo CHAR(4) que acepte nulos
    manager_no con datos de tipo INTEGER(11) y que no acepte nulos
Pero inicia el código de manera que se borre la tabla emp_manager sí la
tabla existe.  Si no existe, que no la borre.
*/


    
/* Rellena la tabla creada emp_manager con la siguiente estructura
INSERT INTO emp_manager SELECT
U.*
FROM 
	(A)
    UNION (B) UNION (C) UNION (D) AS U;
Básate en el código visto previamente cuando hacíamos la unión de 2 tablas construídas al vuelo.
Para este ejercicio, A y B deben ser los mismos subconjuntos utilizados previamente. O sea
asignar a los empleados 10001 al 10020 el empleado 110022 como manager y a los empleados
10021 al 10040 el empleado 110039 como manager.
Después usando la estructura del subconjunto A, modifícala para crear un subconjunto C en el que
debes asignar al número de empleado 110039 como responsable del empleado 110022.
Siguiendo la misma lógica, crea el subconjunto D donde el empleado 110022 sea el gerente (manager) del
empleado 110039.

La salida debe devolverte 42 registros... Suerte!
*/


    
    
##########################################################
##########################################################

-- Vistas SQL

##########################################################
########################################################## 

/* Analiza el siguiente código */

CREATE OR REPLACE VIEW v_dept_emp_latest_date_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;

/* Estamos construyendo una vista (si existe se reemplaza) llamada
v_dept_emp_lastest_date cuyo alias es un SELECT
Comprueba ahora en la BBDD employees la sección Views, verás
una nueva vista llamada v_dept_emp_latest_date_dept_emp_latest_date */

/* Comprueba los registros de dicha vista */



/* Crea una vista que extraiga el salario medio de todos los directivos 
registrados en la base de datos. Redondea este valor al céntimo más próximo.

Si la consulta es correcta, la vista debería devolver el valor de 66924,27. */



##########################################################
##########################################################

-- Índices

##########################################################
##########################################################  

/* Ejecuta la siguiente consulta y comprueba el tiempo de ejecución */
SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';

/* Ahora crea el siguiente índice */
CREATE INDEX i_hire_date ON employees(hire_date);

/* Comprueba como el nuevo índice aparece en la sección de índices de la tabla employees */

/* Ejecuta la consulta anterior y compara los tiempos de respuesta */

/* Ejecuta la siguiente consulta y comprueba los tiempos de ejecución */
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';
        
/* Crea un índice compuesto (índice de varias columnas),
llámalo i_composite y que esté basado en las columnas first_name y last_name
de la tabla employees.
Una vez creado, comprueba que el índice exista en la tabla y
vuelve a ejecutar la consulta anterior, y compara los tiempos de respuesta */



/* Elimina el índice con el siguiente código */
ALTER TABLE employees
DROP INDEX i_hire_date;

/* Para acelerar las consultas basadas en los salarios de los empleados,
crea un índice y llámalo como quieras.  Comprueba mediante código que 
el índice se ha creado correctamente */



##########################################################
##########################################################

-- FIN.  Muchas gracias.

##########################################################
##########################################################  
