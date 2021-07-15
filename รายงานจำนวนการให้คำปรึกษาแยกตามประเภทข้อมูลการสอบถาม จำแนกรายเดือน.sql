SELECT 
count(PPMS_T_CONSULT.id),
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
count (case when PPMS_T_CONSULT.QUESTION = 'ข้อมูลการทำประกันภัย' then 1  end) as info,
count (case when PPMS_T_CONSULT.QUESTION = 'ข้อมูลการทำประกันภัย' then 1  end)*100/count(PPMS_T_CONSULT.id) AS info_per ,
count (case when PPMS_T_CONSULT.QUESTION = 'การขอรับค่าเสียหายเบื้องต้น' then 1  end) as damages,
count (case when PPMS_T_CONSULT.QUESTION = 'การขอรับค่าเสียหายเบื้องต้น' then 1  end)*100/count(PPMS_T_CONSULT.id) AS damages_per,
count (case when PPMS_T_CONSULT.QUESTION = 'การขอรับค่าสินไหมทดแทน' then 1  end) as compensation,
count (case when PPMS_T_CONSULT.QUESTION = 'การขอรับค่าสินไหมทดแทน' then 1  end)*100/count(PPMS_T_CONSULT.id) AS compensation_per,
count (case when PPMS_T_CONSULT.QUESTION = 'การซ่อมรถ' then 1  end) as carfix,
count (case when PPMS_T_CONSULT.QUESTION = 'การซ่อมรถ' then 1  end)*100/count(PPMS_T_CONSULT.id) AS carfix_per,
count (case when PPMS_T_CONSULT.QUESTION = 'อัตราเบี้ยประกันภัย' then 1  end) as insurance_premim,
count (case when PPMS_T_CONSULT.QUESTION = 'อัตราเบี้ยประกันภัย' then 1  end)*100/count(PPMS_T_CONSULT.id) AS insurance_premim_per,
count (case when PPMS_T_CONSULT.QUESTION = 'ข้อมูลเกี่ยวกับบริษัทประกัน' then 1  end) as insurer_info,
count (case when PPMS_T_CONSULT.QUESTION = 'ข้อมูลเกี่ยวกับบริษัทประกัน' then 1  end)*100/count(PPMS_T_CONSULT.id) AS insurer_info_per,
count (case when PPMS_T_CONSULT.QUESTION = 'ร้องเรียนพฤติกรรมบริษัท' then 1  end) as complain_com,
count (case when PPMS_T_CONSULT.QUESTION = 'ร้องเรียนพฤติกรรมบริษัท' then 1  end)*100/count(PPMS_T_CONSULT.id) AS complain_com_per,
count (case when PPMS_T_CONSULT.QUESTION = 'ร้องเรียนพฤติกรรมตัวแทน' then 1  end) as complain_agent,
count (case when PPMS_T_CONSULT.QUESTION = 'ร้องเรียนพฤติกรรมตัวแทน' then 1  end)*100/count(PPMS_T_CONSULT.id) AS complain_agent_per,
count (case when PPMS_T_CONSULT.QUESTION = 'อื่นๆ' then 1  end) as etc,
count (case when PPMS_T_CONSULT.QUESTION = 'อื่นๆ' then 1  end) *100/count(PPMS_T_CONSULT.id) AS etc_per
from PPMS_T_CONSULT
LEFT JOIN PPMS_T_DEPARTMENT ON PPMS_T_CONSULT.DEPARTMENT_ID = PPMS_T_DEPARTMENT.ID
where DATE_OF_CONSULT between $P{start_date_time} and $P{end_date_time} 
and $X{IN,PPMS_T_DEPARTMENT.name,department}
and PPMS_T_DEPARTMENT.name is not null
GROUP BY PPMS_T_DEPARTMENT.NAME, TO_CHAR(DATE_OF_CONSULT,'YYYY'),TO_CHAR(DATE_OF_CONSULT,'MM')
ORDER BY PPMS_T_DEPARTMENT.NAME, TO_CHAR(DATE_OF_CONSULT,'YYYY'),TO_CHAR(DATE_OF_CONSULT,'MM'),count(PPMS_T_CONSULT.id) DESC