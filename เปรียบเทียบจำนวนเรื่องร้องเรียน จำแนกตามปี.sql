select to_char(DATE_OF_COMP, 'YYYY','nls_calendar=''Thai Buddha'' nls_date_language = Thai') as year_name,
count(insur_type) AS COUNTTYPE,
count(case when insur_type = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE = 'รถยนต์'  then 1 end) as WINAS_CAR,
count(case when insur_type = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE != 'รถยนต์'  then 1 end) as WINAS_NOTCAR,
count(case when insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' then 1 end) as PAKARNCHEVIT,
count(case when insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' then 1 end) as NAINA,
(select count(insur_type) from "PPMS_T_COMPLAINT" WHERE DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time} ) as TOTAL,
(select count(insur_type) from "PPMS_T_COMPLAINT" where insur_type = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE = 'รถยนต์' AND DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}  ) as TOTALWINAS_CAR,
(select count(insur_type) from "PPMS_T_COMPLAINT" where insur_type = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE != 'รถยนต์' AND DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time} ) as TOTALWINAS_NOTACR,
(select count(insur_type) from "PPMS_T_COMPLAINT" where  insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' AND DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time} ) as TOTALPAKARNCHEVIT,
(select count(insur_type) from "PPMS_T_COMPLAINT" where  insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย'  AND DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}) as TOTALNAINA

FROM PPMS_T_COMPLAINT COMPLAINT 
LEFT JOIN PPMS_T_DEPARTMENT DEPARTMENT ON COMPLAINT.DEPARTMENT_ID = DEPARTMENT.ID
LEFT JOIN "user" userid on COMPLAINT.ASSIGNED_USER_ID = userid.ID 
WHERE DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}
AND $X{IN,DEPARTMENT.name,department}
AND $X{IN,userid.id,Responsible_person}
group by to_char(DATE_OF_COMP, 'YYYY','nls_calendar=''Thai Buddha'' nls_date_language = Thai')
ORDER by to_char(DATE_OF_COMP, 'YYYY','nls_calendar=''Thai Buddha'' nls_date_language = Thai')