SELECT
    TO_CHAR(t.numrut, 'FM99G999G999',
        'NLS_NUMERIC_CHARACTERS='',.''')
        AS "RUT Trabajador",

    INITCAP(t.nombre || ' ' || t.appaterno)
        AS "Trabajador Nombre",

    EXTRACT(YEAR FROM t.fecing)
        AS "Año Ingreso",

    EXTRACT(YEAR FROM SYSDATE) -
    EXTRACT(YEAR FROM t.fecing)
        AS "Años Antigüedad",

    (SELECT COUNT(*)
     FROM asignacion_familiar af
     WHERE af.numrut_t = t.numrut)
        AS "Num. Cargas Familiares",

    INITCAP(i.nombre_isapre)
        AS "Nombre Isapre",

    '$' || TO_CHAR(t.sueldo_base,
        'FM999G999G999',
        'NLS_NUMERIC_CHARACTERS='',.''')
        AS "Sueldo Base",

    CASE
        WHEN UPPER(i.nombre_isapre) = 'FONASA'
        THEN '$' || TO_CHAR(
            ROUND(t.sueldo_base * 0.01),
            'FM999G999G999',
            'NLS_NUMERIC_CHARACTERS='',.''')
        ELSE '0'
    END AS "Bono Fonasa",

    '$' || TO_CHAR(
        ROUND(
            CASE
                WHEN EXTRACT(YEAR FROM SYSDATE) -
                     EXTRACT(YEAR FROM t.fecing) <= 10
                THEN t.sueldo_base * 0.10
                ELSE t.sueldo_base * 0.15
            END
        ),
        'FM999G999G999',
        'NLS_NUMERIC_CHARACTERS='',.''')
        AS "Bono Antigüedad",

    INITCAP(a.nombre_afp)
        AS "Nombre AFP",

    UPPER(ec.desc_estcivil)
        AS "Estado Civil"

FROM trabajador t

INNER JOIN isapre i
    ON t.cod_isapre = i.cod_isapre

INNER JOIN afp a
    ON t.cod_afp = a.cod_afp

INNER JOIN est_civil e
    ON t.numrut = e.numrut_t

INNER JOIN estado_civil ec
    ON e.id_estcivil_est = ec.id_estcivil

WHERE e.fecter_estcivil IS NULL
   OR e.fecter_estcivil > SYSDATE

ORDER BY t.numrut;
