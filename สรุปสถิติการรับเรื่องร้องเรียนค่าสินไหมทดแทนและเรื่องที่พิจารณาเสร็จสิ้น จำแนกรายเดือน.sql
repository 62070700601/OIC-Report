SELECT 
TO_CHAR(DATE_OF_COMP,'MM') as DATEMONTH,
TO_CHAR(DATE_OF_COMP,'YYYY') as DATEYEAR,
TO_CHAR(DATE_OF_COMP,'YYYY') + 543 AS thaiyear,
CASE
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 01 THEN 'มกราคม'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 02 THEN 'กุมภาพันธ์.'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 03 THEN 'มีนาคม'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 04 THEN 'เมษายน'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 05 THEN 'พฤษภาคม'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 06 THEN 'มิถุนายน'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 07 THEN 'กรกฎาคม'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 08 THEN 'สิงหาคม'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 09 THEN 'กันยายน'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 10 THEN 'ตุลาคม'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 11 THEN 'พฤศจิกายน'
	WHEN TO_CHAR(DATE_OF_COMP,'MM') = 12 THEN 'ธันวาคม'    
END as monthfontthai,
-- ประกันชีวิต/สุขภาพ //เรือ่งร้องเรียนที่ยกมา
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' AND COMPLAINT.STATUS  = 'รับเรื่อง' then 1 end) AS GETCALLHEALTH,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' AND COMPLAINT.STATUS  = 'ยุติ' then 1 end) AS ENDCALLHEALTH,
--count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' AND COMPLAINT.AMOUNT_OF_TERMINATE  != '' end) AS ENDCALLHEALTH,
-- ประกันวินาศภัย //เรือ่งร้องเรียนที่ยกมา
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' AND COMPLAINT.STATUS = 'รับเรื่อง' then 1 end) AS  GETCALLCASH,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' AND COMPLAINT.STATUS  = 'ยุติ' then 1 end) AS ENDCALLCASH,
-- ประกันชีวิต+ประกันวินาศภัย //เรือ่งร้องเรียนที่ยกมา
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' AND COMPLAINT.STATUS  = 'รับเรื่อง' then 1 end) AS GETCALLBOTH,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' AND COMPLAINT.STATUS  = 'ยุติ'then 1 end) AS ENDCALLBOTH,
SUM(CASE WHEN COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' THEN COMPLAINT.amount_of_terminate ELSE 0 END) AS amount_chevit,
SUM(CASE WHEN COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' THEN COMPLAINT.amount_of_terminate ELSE 0 END) AS amount_winas,
SUM(CASE WHEN COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' THEN COMPLAINT.amount_of_terminate ELSE 0 END) AS amount_naina




FROM PPMS_T_COMPLAINT COMPLAINT 
LEFT JOIN  PPMS_T_COMPLAINANT COMPLAINANT ON COMPLAINT.ID = COMPLAINANT.PARENT_ID
LEFT JOIN  PPMS_T_COMPLAINANT_INSU COMPLAINANT_INSU ON COMPLAINANT.ID = PPMS_T_COMPLAINANT_ID
LEFT JOIN "user" userid on COMPLAINT.ASSIGNED_USER_ID = userid.ID 
LEFT JOIN PPMS_T_DEPARTMENT DEPARTMENT ON COMPLAINT.DEPARTMENT_ID = DEPARTMENT.ID
LEFT JOIN PPMS_T_COMPLAINT_INSU CI ON  COMPLAINT.ID = CI.PARENT_ID
WHERE COMPLAINT.STATUS IS NOT NULL 
 and DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}
AND $X{IN,DEPARTMENT.name,department}
AND $X{IN,userid.id,Responsible_person}
AND $X{IN,COMPLAINT.INSUR_TYPE,insuretype} 
GROUP BY TO_CHAR(DATE_OF_COMP,'YYYY'),TO_CHAR(DATE_OF_COMP,'MM')
ORDER BY TO_CHAR(DATE_OF_COMP,'YYYY'),TO_CHAR(DATE_OF_COMP,'MM')