SELECT ROWNUM,COMPLAINT.COMP_NUMBER,COMPLAINT.DATE_OF_COMP,COMPLAINANT.FIRST_NAME,COMPLAINANT.LAST_NAME,COMPLAINT.INSUR_TYPE,
COMPLAINT.DISPUTE_ISSUE,COMPLAINANT_INSU.NAME,COMPLAINT.STATUS,COMPLAINT.REQUEST_ISSUE,COMPLAINT.DATE_OF_ASSIGNED ,userid.USER_NAME
FROM PPMS_T_COMPLAINT COMPLAINT 
LEFT JOIN  PPMS_T_COMPLAINANT COMPLAINANT ON COMPLAINT.ID = COMPLAINANT.PARENT_ID
LEFT JOIN  PPMS_T_COMPLAINANT_INSU COMPLAINANT_INSU ON COMPLAINANT.ID = PPMS_T_COMPLAINANT_ID
LEFT JOIN "user" userid on COMPLAINT.ASSIGNED_USER_ID = userid.ID 
LEFT JOIN PPMS_T_DEPARTMENT DEPARTMENT ON COMPLAINT.DEPARTMENT_ID = DEPARTMENT.ID
LEFT JOIN PPMS_T_COMPLAINT_INSU CI ON  COMPLAINT.ID = CI.PARENT_ID
WHERE 
COMPLAINT.status != 'ยุติ'
and DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}
AND $X{IN,DEPARTMENT.name,department}
AND $X{IN,userid.id,Responsible_person}
AND $X{IN,COMPLAINT.INSUR_TYPE,insuretype}