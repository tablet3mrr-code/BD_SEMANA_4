SELECT
(TO_CHAR(t.NUMRUT, '999G999G999')|| '-' || t.DVRUT) as "Rut Trabajador",
INITCAP(t.nombre) || ' ' || UPPER(t.appaterno) as "Nombre Completo Trabajador",
COUNT(distinct ti.nro_ticket) AS "Total Tickets",
TO_CHAR(SUM(ti.monto_ticket), '$999G999G999') as "Total Vendido",
TO_CHAR(SUM(ct.valor_comision), '$999G999G999') as "Comision Total",
tt.desc_categoria as "Tipo Trabajador",
UPPER(cc.nombre_ciudad) as "Ciudad Trabajador"
FROM TRABAJADOR t
JOIN TIPO_TRABAJADOR tt
ON t.id_categoria_t = tt.id_categoria
JOIN COMUNA_CIUDAD cc
ON t.id_ciudad = cc.id_ciudad
JOIN TICKETS_CONCIERTO ti
ON t.numrut = ti.numrut_t
JOIN COMISIONES_TICKET ct
on ct.nro_ticket = ti.nro_ticket
WHERE tt.desc_categoria = 'CAJERO' AND ti.monto_ticket> 50000
GROUP BY t.numrut, t.dvrut, t.nombre, t.appaterno, tt.desc_categoria, cc.nombre_ciudad
ORDER BY "Total Vendido" desc;