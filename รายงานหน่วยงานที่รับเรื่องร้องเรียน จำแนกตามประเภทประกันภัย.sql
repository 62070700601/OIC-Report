SELECT DEPARTMENT.NAME,
count(case when COMPLAINT.STATUS  = 'รับเรื่อง' AND COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' then 1 end) AS UC1,
count(case when COMPLAINT.STATUS  = 'รับเรื่อง' AND COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' then 1 end) AS UC2,
count(case when COMPLAINT.STATUS  = 'รับเรื่อง' AND COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' then 1 end) AS UC3,
count(case when COMPLAINT.STATUS  = 'ยุติ' AND COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' then 1 end) AS UC4,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' then 1 end) AS UC4_1,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' AND COMPLAINT.STATUS = 'รอเอกสาร/หลักฐาน' then 1 end) AS  UC4_2,

count(case when COMPLAINT.STATUS  = 'ยุติ' AND COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' then 1 end) AS UC5,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' then 1 end) AS UC5_1,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' AND COMPLAINT.STATUS = 'รอเอกสาร/หลักฐาน' then 1 end) AS  UC5_2,

count(case when COMPLAINT.STATUS  = 'ยุติ' AND COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' then 1 end) AS UC6,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' then 1 end) AS UC6_1,
count(case when COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' AND COMPLAINT.STATUS = 'รอเอกสาร/หลักฐาน' then 1 end) AS  UC6_2,

count(case when COMPLAINT.STATUS IN ('กำลังดำเนินการ','มอบหมายงาน','รอเอกสาร/หลักฐาน') AND COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' then 1 end) AS UC7,
count(case when COMPLAINT.STATUS IN ('กำลังดำเนินการ','มอบหมายงาน','รอเอกสาร/หลักฐาน')AND COMPLAINT.INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' then 1 end) AS UC8,
count(case when COMPLAINT.STATUS  IN ('กำลังดำเนินการ','มอบหมายงาน','รอเอกสาร/หลักฐาน') AND COMPLAINT.INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' then 1 end) AS UC9
FROM PPMS_T_COMPLAINT COMPLAINT 
LEFT JOIN  PPMS_T_COMPLAINANT COMPLAINANT ON COMPLAINT.ID = COMPLAINANT.PARENT_ID
LEFT JOIN "user" userid on COMPLAINT.ASSIGNED_USER_ID = userid.ID 
LEFT JOIN PPMS_T_DEPARTMENT DEPARTMENT ON COMPLAINT.DEPARTMENT_ID = DEPARTMENT.ID
WHERE DEPARTMENT.NAME IS NOT NULL 
AND DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}
AND $X{IN,DEPARTMENT.name,department}
AND $X{IN,userid.id,Responsible_person} 
GROUP BY DEPARTMENT.NAME
ORDER BY DEPARTMENT.NAME