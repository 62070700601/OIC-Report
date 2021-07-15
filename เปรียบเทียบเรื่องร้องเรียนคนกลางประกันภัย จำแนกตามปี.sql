select to_char(DATE_OF_COMP, 'YYYY','nls_calendar=''Thai Buddha'' nls_date_language = Thai') as year_name,
count(insur_type) AS COUNTINSURTYPE,
count(case when comp_type = 'ตัวแทนประกันชีวิต (บุคคลธรรมดา)' then 1 end) as BEHALFPAKARNCHEVIT,
count(case when comp_type = 'นายหน้าประกันชีวิต (บุคคลธรรมดา)' then 1 end) as NAINAPAKARNCHEVIT_PERSONAL,
count(case when comp_type = 'นายหน้าประกันชีวิต (นิติบุคคล)' then 1 end) as NAINAPAKARNCHEVIT,
count(case when comp_type = 'ตัวแทนประกันวินาศภัย (บุคคลธรรมดา)' then 1 end) as BEHALFWINAS,
count(case when comp_type = 'นายหน้าประกันวินาศภัย (บุคคลธรรมดา)' then 1 end) as NAINAWINAS_PERSONAL,
count(case when comp_type = 'นายหน้าประกันวินาศภัย (นิติบุคคล)' then 1 end) as NAINAWINAS,
count(case when comp_type = 'อื่นๆ' then 1 end) as ETC

FROM PPMS_T_COMPLAINT COMPLAINT 
LEFT JOIN  PPMS_T_COMPLAINANT COMPLAINANT ON COMPLAINT.ID = COMPLAINANT.PARENT_ID
LEFT JOIN  PPMS_T_COMPLAINANT_INSU COMPLAINANT_INSU ON COMPLAINANT.ID = PPMS_T_COMPLAINANT_ID
LEFT JOIN "user" userid on COMPLAINT.ASSIGNED_USER_ID = userid.ID 
LEFT JOIN PPMS_T_DEPARTMENT DEPARTMENT ON COMPLAINT.DEPARTMENT_ID = DEPARTMENT.ID
where insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย'
and DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}
AND $X{IN,DEPARTMENT.name,department}
AND $X{IN,userid.id,Responsible_person}
group by to_char(DATE_OF_COMP, 'YYYY','nls_calendar=''Thai Buddha'' nls_date_language = Thai')
ORDER by to_char(DATE_OF_COMP, 'YYYY','nls_calendar=''Thai Buddha'' nls_date_language = Thai')