SELECT 
TO_CHAR(DATE_OF_COMP,'YYYY') as DATEYEAR,
TO_CHAR(DATE_OF_COMP,'YYYY') + 543 AS thaiyear,

count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' then 1 end) AS ACTCOUNT,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' AND COMPLAINT.STATUS  = 'รอเอกสาร/หลักฐาน' then 1 end) AS ACTWATING,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' AND COMPLAINT.STATUS  = 'กำลังดำเนินการ' then 1 end) AS ACTDOING,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' AND COMPLAINT.STATUS  = 'ยุติ' then 1 end) AS ACTDONE,
SUM(CASE WHEN COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' AND COMPLAINT.STATUS  = 'ยุติ' THEN COMPLAINT.amount_of_terminate ELSE 0 END) AS ACTMONEYDONE,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' then 1 end) AS INSURCOUNT,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' AND COMPLAINT.STATUS = 'รอเอกสาร/หลักฐาน' then 1 end) AS  INSURWATING,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' AND COMPLAINT.STATUS  = 'กำลังดำเนินการ' then 1 end) AS INSURDOING,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' AND COMPLAINT.STATUS  = 'ยุติ' then 1 end) AS INSURDONE,
SUM(CASE WHEN COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' AND COMPLAINT.STATUS  = 'ยุติ' THEN COMPLAINT.amount_of_terminate ELSE 0 END) AS INSURMONEYDONE,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' then 1 end) AS NON_INSURCOUNT,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัยย' AND COMPLAINT.STATUS  = 'รอเอกสาร/หลักฐาน' then 1 end) AS NON_INSURWATING,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' AND COMPLAINT.STATUS  = 'กำลังดำเนินการ'then 1 end) AS NON_INSURDOING,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' AND COMPLAINT.STATUS  = 'ยุติ' then 1 end) AS NON_INSURDONE,
SUM(CASE WHEN COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' AND COMPLAINT.STATUS  = 'ยุติ' THEN COMPLAINT.amount_of_terminate ELSE 0 END) AS NON_MONEYINSURDONE,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' OR COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' OR COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' then 1 end) AS SUMCOUNT,
count(case when COMPLAINT.STATUS  = 'รอเอกสาร/หลักฐาน' then 1 end) AS SUMWATING,
count(case when COMPLAINT.STATUS  = 'กำลังดำเนินการ'then 1 end) AS SUMDOING,
count(case when COMPLAINT.STATUS  = 'ยุติ' then 1 end) AS SUMDONE,
SUM(CASE WHEN COMPLAINT.STATUS  = 'ยุติ' THEN COMPLAINT.amount_of_terminate ELSE 0 END) AS SUMMONEYDONE
FROM PPMS_T_COMPLAINT COMPLAINT 
LEFT JOIN  PPMS_T_COMPLAINANT COMPLAINANT ON COMPLAINT.ID = COMPLAINANT.PARENT_ID
LEFT JOIN  PPMS_T_COMPLAINANT_INSU COMPLAINANT_INSU ON COMPLAINANT.ID = PPMS_T_COMPLAINANT_ID
LEFT JOIN "user" userid on COMPLAINT.ASSIGNED_USER_ID = userid.ID 
LEFT JOIN PPMS_T_DEPARTMENT DEPARTMENT ON COMPLAINT.DEPARTMENT_ID = DEPARTMENT.ID
LEFT JOIN PPMS_T_COMPLAINT_INSU CI ON  COMPLAINT.ID = CI.PARENT_ID
WHERE COMPLAINT.STATUS IS NOT NULL and DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}
AND $X{IN,DEPARTMENT.name,department}
AND $X{IN,userid.id,Responsible_person}
AND $X{IN,COMPLAINT.INSUR_TYPE,insuretype}
GROUP BY TO_CHAR(DATE_OF_COMP,'YYYY')
ORDER BY TO_CHAR(DATE_OF_COMP,'YYYY')