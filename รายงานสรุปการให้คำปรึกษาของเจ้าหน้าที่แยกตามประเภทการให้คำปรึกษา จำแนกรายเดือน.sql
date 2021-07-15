select
count(PPMS_T_CONSULT.ID) as total,
TO_CHAR(DATE_OF_CONSULT,'MM') as DATEMONTH,
TO_CHAR(DATE_OF_CONSULT,'YYYY') as DATEYEAR,
TO_CHAR(DATE_OF_CONSULT,'YYYY') + 543 AS thaiyear,
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
count (case when PPMS_T_CONSULT.TYPE = 'รถยนต์ภาคบังคับ' then 1  end) as car_fix,
count (case when PPMS_T_CONSULT.TYPE = 'รถยนต์ภาคสมัครใจ' then 1  end) as car_flex,
count (case when PPMS_T_CONSULT.TYPE = 'ทะเล' then 1  end) as sea,
count (case when PPMS_T_CONSULT.TYPE = 'ขนส่ง' then 1  end) as transport,
count (case when PPMS_T_CONSULT.TYPE = 'อุบัติเหตุส่วนบุคคล (PA)' then 1  end) as pa,
count (case when PPMS_T_CONSULT.TYPE = 'สัญญาการประกันสุขภาพ' then 1  end) as health,
count (case when PPMS_T_CONSULT.TYPE = 'อัคคีภัย' then 1  end) as fire,
count (case when PPMS_T_CONSULT.TYPE = 'กรมธรรม์ประกันภัยความเสี่ยงภัยทุกชนิด IAR' then 1  end) as iar,
count (case when PPMS_T_CONSULT.TYPE = 'อื่นๆ' then 1  end) as etc,
"user".SALUTATION_NAME || ' ' || "user".FIRST_NAME || ' ' || "user".LAST_NAME as agent,
PPMS_T_DEPARTMENT.name AS department,
CHANNEL
from PPMS_T_CONSULT
LEFT JOIN "user" ON PPMS_T_CONSULT.ASSIGNED_USER_ID = "user".ID
LEFT JOIN PPMS_T_DEPARTMENT ON PPMS_T_CONSULT.DEPARTMENT_ID = PPMS_T_DEPARTMENT.ID
where DATE_OF_CONSULT between $P{start_date_time} and $P{end_date_time} 
and $X{IN,PPMS_T_DEPARTMENT.name,department}
and $X{IN,CHANNEL,channel}
and PPMS_T_DEPARTMENT.name is not null
and PPMS_T_CONSULT.ASSIGNED_USER_ID is not null
group by PPMS_T_DEPARTMENT.NAME,TO_CHAR(DATE_OF_CONSULT,'YYYY'),TO_CHAR(DATE_OF_CONSULT,'MM'), "user".SALUTATION_NAME || ' ' || "user".FIRST_NAME || ' ' || "user".LAST_NAME, CHANNEL
order by PPMS_T_DEPARTMENT.NAME,TO_CHAR(DATE_OF_CONSULT,'YYYY'),TO_CHAR(DATE_OF_CONSULT,'MM'), "user".SALUTATION_NAME || ' ' || "user".FIRST_NAME || ' ' || "user".LAST_NAME, CHANNEL, count(PPMS_T_CONSULT.id) DESC