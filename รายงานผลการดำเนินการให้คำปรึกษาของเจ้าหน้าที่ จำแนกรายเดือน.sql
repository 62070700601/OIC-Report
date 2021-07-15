SELECT
count(PPMS_T_CONSULT.ID) AS consult_total,
PPMS_T_DEPARTMENT.NAME AS department,
TO_CHAR(DATE_OF_CONSULT,'MM') as DATEMONTH,
CASE
    WHEN TO_CHAR(DATE_OF_CONSULT,'MM') = 01 THEN 'มกราคม'
    WHEN TO_CHAR(DATE_OF_CONSULT,'MM') = 02 THEN 'กุมภาพันธ์.'
    WHEN TO_CHAR(DATE_OF_CONSULT,'MM') = 03 THEN 'มีนาคม'
    WHEN TO_CHAR(DATE_OF_CONSULT,'MM') = 04 THEN 'เมษายน'
    WHEN TO_CHAR(DATE_OF_CONSULT,'MM') = 05 THEN 'พฤษภาคม'
    WHEN TO_CHAR(DATE_OF_CONSULT,'MM') = 06 THEN 'มิถุนายน'
    WHEN TO_CHAR(DATE_OF_CONSULT,'MM') = 07 THEN 'กรกฎาคม'
    WHEN TO_CHAR(DATE_OF_CONSULT,'MM') = 08 THEN 'สิงหาคม'
    WHEN TO_CHAR(DATE_OF_CONSULT,'MM') = 09 THEN 'กันยายน'
    WHEN TO_CHAR(DATE_OF_CONSULT,'MM') = 10 THEN 'ตุลาคม'
    WHEN TO_CHAR(DATE_OF_CONSULT,'MM') = 11 THEN 'พฤศจิกายน'
	WHEN TO_CHAR(DATE_OF_CONSULT,'MM') = 12 THEN 'ธันวาคม'    
END as monthfontthai,
TO_CHAR(DATE_OF_CONSULT,'YYYY') as DATEYEAR,
TO_CHAR(DATE_OF_CONSULT,'YYYY') + 543 AS thaiyear,
count (case when PPMS_T_CONSULT.STATUS = 'ใหม่' then 1  end) as consult_new,
count (case when PPMS_T_CONSULT.STATUS = 'ให้คำปรึกษาแล้ว' then 1  end) as consulted,
count (case when PPMS_T_CONSULT.STATUS = 'ส่งเรื่องไประบบอื่น' then 1  end) as converted,
PPMS_T_DEPARTMENT.NAME AS department,
"user".SALUTATION_NAME || ' ' || "user".FIRST_NAME || ' ' || "user".LAST_NAME as agent
from PPMS_T_CONSULT
LEFT JOIN PPMS_T_DEPARTMENT ON PPMS_T_CONSULT.DEPARTMENT_ID = PPMS_T_DEPARTMENT.ID
LEFT JOIN "user" ON PPMS_T_CONSULT.ASSIGNED_USER_ID = "user".ID
where DATE_OF_CONSULT between $P{start_date_time} and $P{end_date_time}
and $X{IN,PPMS_T_DEPARTMENT.NAME,department}
and PPMS_T_DEPARTMENT.name is not null
and PPMS_T_CONSULT.ASSIGNED_USER_ID is not null
GROUP BY PPMS_T_DEPARTMENT.NAME,TO_CHAR(DATE_OF_CONSULT,'YYYY'),TO_CHAR(DATE_OF_CONSULT,'MM'), "user".SALUTATION_NAME || ' ' || "user".FIRST_NAME || ' ' || "user".LAST_NAME
ORDER BY PPMS_T_DEPARTMENT.NAME,TO_CHAR(DATE_OF_CONSULT,'YYYY'),TO_CHAR(DATE_OF_CONSULT,'MM'), consult_total DESC, "user".SALUTATION_NAME || ' ' || "user".FIRST_NAME || ' ' || "user".LAST_NAME, count(PPMS_T_CONSULT.id) DESC