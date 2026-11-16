SELECT
t.nombre || ' ' || t.appaterno || ' ' || t.apmaterno as "Nombre Completo Trabajador",
(TO_CHAR(t.NUMRUT, '999G999G999')|| '-' || t.DVRUT) as "Rut Trabajador",
tt.desc_categoria as "Tipo Trabajador",
UPPER(cc.nombre_ciudad) as "Ciudad Trabajador",
TO_CHAR(sueldo_base, '$999G999G999') AS "Sueldo Base"

FROM TRABAJADOR t
JOIN TIPO_TRABAJADOR tt
ON t.id_categoria_t = tt.id_categoria
JOIN COMUNA_CIUDAD cc
ON t.id_ciudad = cc.id_ciudad
WHERE t.sueldo_base BETWEEN 650000 AND 3000000
ORDER BY cc.nombre_ciudad desc;