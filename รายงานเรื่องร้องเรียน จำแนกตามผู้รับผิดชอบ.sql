SELECT (userid.SALUTATION_NAME || ' ' || userid.FIRST_NAME || ' ' || userid.LAST_NAME) AS FULL_NAME_USER,
COUNT(COMPLAINT.created_by_id) AS CREATEBYID,
count(case when COMPLAINT.status = 'รับเรื่อง' then 1 end) as RUBRENG,
count(case when COMPLAINT.status = 'มอบหมายงาน' then 1 end) as ASSIGNED,
count(case when COMPLAINT.status = 'กำลังดำเนินการ' then 1 end) as CONTINUING,
count(case when COMPLAINT.status = 'รอเอกสาร/หลักฐาน' then 1 end) as Converted1,
count(case when COMPLAINT.status = 'ยุติ' then 1 end) as YUTI

FROM PPMS_T_COMPLAINT COMPLAINT 
LEFT JOIN PPMS_T_DEPARTMENT DEPARTMENT ON COMPLAINT.DEPARTMENT_ID = DEPARTMENT.ID
LEFT JOIN "user" userid on COMPLAINT.created_by_id = userid.ID 
LEFT JOIN PPMS_T_COMPLAINANT COMPLAINANT ON COMPLAINT.ID = COMPLAINANT.PARENT_ID
LEFT JOIN  PPMS_T_COMPLAINANT_INSU COMPLAINANT_INSU ON COMPLAINANT.ID = PPMS_T_COMPLAINANT_ID

WHERE 
DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}
AND $X{IN,userid.id,Responsible_person}
AND $X{IN,COMPLAINT.INSUR_TYPE,insuretype}

group by userid.SALUTATION_NAME || ' ' || userid.FIRST_NAME || ' ' || userid.LAST_NAME