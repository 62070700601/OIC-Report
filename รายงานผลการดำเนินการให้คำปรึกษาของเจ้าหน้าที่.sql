SELECT
count(PPMS_T_CONSULT.ID) AS consult_total,
count (case when PPMS_T_CONSULT.STATUS = 'ใหม่' then 1  end) as consult_new,
count (case when PPMS_T_CONSULT.STATUS = 'ให้คำปรึกษาแล้ว' then 1  end) as consulted,
count (case when PPMS_T_CONSULT.STATUS = 'ส่งเรื่องไประบบอื่น' then 1  end) as converted,
PPMS_T_DEPARTMENT.NAME AS department,
"user".SALUTATION_NAME || ' ' || "user".FIRST_NAME || ' ' || "user".LAST_NAME as agent
from PPMS_T_CONSULT
LEFT JOIN PPMS_T_DEPARTMENT ON PPMS_T_CONSULT.DEPARTMENT_ID = PPMS_T_DEPARTMENT.ID
LEFT JOIN "user" ON PPMS_T_CONSULT.ASSIGNED_USER_ID = "user".ID
where DATE_OF_CONSULT between $P{start_date_time} and $P{end_date_time} 
and $X{IN,PPMS_T_DEPARTMENT.name,department}
and PPMS_T_DEPARTMENT.name is not null
and PPMS_T_CONSULT.ASSIGNED_USER_ID is not null
GROUP BY PPMS_T_DEPARTMENT.NAME, "user".SALUTATION_NAME || ' ' || "user".FIRST_NAME || ' ' || "user".LAST_NAME
ORDER BY PPMS_T_DEPARTMENT.NAME, consult_total DESC, "user".SALUTATION_NAME || ' ' || "user".FIRST_NAME || ' ' || "user".LAST_NAME