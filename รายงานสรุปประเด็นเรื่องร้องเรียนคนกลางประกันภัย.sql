SELECT DISPUTE_ISSUE,COUNT(DISPUTE_ISSUE) as COUNTTYPE,(select count(*) from "PPMS_T_COMPLAINT" WHERE 
INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}) as percentage


FROM PPMS_T_COMPLAINT COMPLAINT 
LEFT JOIN PPMS_T_DEPARTMENT DEPARTMENT ON COMPLAINT.DEPARTMENT_ID = DEPARTMENT.ID
LEFT JOIN "user" userid on COMPLAINT.ASSIGNED_USER_ID = userid.ID 
WHERE INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย'
and DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}
AND $X{IN,DEPARTMENT.name,department}
AND $X{IN,userid.id,Responsible_person}
GROUP BY DISPUTE_ISSUE
ORDER BY COUNTTYPE desc