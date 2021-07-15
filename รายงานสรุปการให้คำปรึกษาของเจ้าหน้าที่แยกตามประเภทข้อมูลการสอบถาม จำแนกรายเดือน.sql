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
count (case when PPMS_T_CONSULT.QUESTION = 'ข้อมูลการทำประกันภัย' then 1  end) as info,
count (case when PPMS_T_CONSULT.QUESTION = 'การขอรับค่าเสียหายเบื้องต้น' then 1  end) as damages,
count (case when PPMS_T_CONSULT.QUESTION = 'การขอรับค่าสินไหมทดแทน' then 1  end) as compensation,
count (case when PPMS_T_CONSULT.QUESTION = 'การซ่อมรถ' then 1  end) as carfix,
count (case when PPMS_T_CONSULT.QUESTION = 'อัตราเบี้ยประกันภัย' then 1  end) as insurance_premim,
count (case when PPMS_T_CONSULT.QUESTION = 'ข้อมูลเกี่ยวกับบริษัทประกัน' then 1  end) as insurer_info,
count (case when PPMS_T_CONSULT.QUESTION = 'ร้องเรียนพฤติกรรมบริษัท' then 1  end) as complain_com,
count (case when PPMS_T_CONSULT.QUESTION = 'ร้องเรียนพฤติกรรมตัวแทน' then 1  end) as complain_agent,
count (case when PPMS_T_CONSULT.QUESTION = 'อื่นๆ' then 1  end) as etc,
"user".SALUTATION_NAME || ' ' || "user".FIRST_NAME || ' ' || "user".LAST_NAME as agent,
PPMS_T_DEPARTMENT.name AS department,
CHANNEL
from PPMS_T_CONSULT
LEFT JOIN "user" ON PPMS_T_CONSULT.ASSIGNED_USER_ID = "user".ID
LEFT JOIN PPMS_T_DEPARTMENT ON PPMS_T_CONSULT.DEPARTMENT_ID = PPMS_T_DEPARTMENT.ID
where DATE_OF_CONSULT between $P{start_date_time} and $P{end_date_time} 
and $X{IN,CHANNEL,channel}
and $X{IN,PPMS_T_DEPARTMENT.name,department}
and PPMS_T_DEPARTMENT.name is not null
and PPMS_T_CONSULT.ASSIGNED_USER_ID is not null
group by PPMS_T_DEPARTMENT.name, TO_CHAR(DATE_OF_CONSULT,'YYYY'),TO_CHAR(DATE_OF_CONSULT,'MM'), "user".SALUTATION_NAME || ' ' || "user".FIRST_NAME || ' ' || "user".LAST_NAME, CHANNEL
order by PPMS_T_DEPARTMENT.name, TO_CHAR(DATE_OF_CONSULT,'YYYY'),TO_CHAR(DATE_OF_CONSULT,'MM'),"user".SALUTATION_NAME || ' ' || "user".FIRST_NAME || ' ' || "user".LAST_NAME, total DESC, CHANNEL