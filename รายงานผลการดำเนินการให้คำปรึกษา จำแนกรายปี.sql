SELECT
count(PPMS_T_CONSULT.ID) AS consult_total,
PPMS_T_DEPARTMENT.NAME AS department,
TO_CHAR(DATE_OF_CONSULT,'YYYY') as DATEYEAR,
TO_CHAR(DATE_OF_CONSULT,'YYYY') + 543 AS thaiyear,
count (case when PPMS_T_CONSULT.STATUS = 'ใหม่' then 1  end) as consult_new,
count (case when PPMS_T_CONSULT.STATUS = 'ให้คำปรึกษาแล้ว' then 1  end) as consulted,
count (case when PPMS_T_CONSULT.STATUS = 'ส่งเรื่องไประบบอื่น' then 1  end) as converted
from PPMS_T_CONSULT
LEFT JOIN PPMS_T_DEPARTMENT ON PPMS_T_CONSULT.DEPARTMENT_ID = PPMS_T_DEPARTMENT.ID
where DATE_OF_CONSULT between $P{start_date_time} and $P{end_date_time}
and $X{IN,PPMS_T_DEPARTMENT.name,department}
and PPMS_T_DEPARTMENT.name is not null
GROUP BY PPMS_T_DEPARTMENT.NAME, TO_CHAR(DATE_OF_CONSULT,'YYYY')
ORDER BY PPMS_T_DEPARTMENT.NAME, TO_CHAR(DATE_OF_CONSULT,'YYYY'),count(PPMS_T_CONSULT.id) DESC