select to_char(DATE_OF_COMP, 'YYYY','nls_calendar=''Thai Buddha'' nls_date_language = Thai') as year_name,
count(insur_type) AS COUNTINSURTYPE,
count(case when comp_type = 'รถยนต์' then 1 end) as WINASCAR,
count(case when comp_type = 'ทะเล' then 1 end) as WINASSEA,
count(case when comp_type = 'ขนส่ง' then 1 end) as WINASTRANSPORATION,
count(case when comp_type = 'กรมธรรม์ความเสี่ยงภัยทรัพย์สิน (IAR)' then 1 end) as WINASIAR,
count(case when comp_type = 'อุบัติเหตุส่วนบุคคล (PA)' then 1 end) as WINASPA,
count(case when comp_type = 'กรมธรรม์ประกันสุขภาพ' then 1 end) as WINASSUKAPARB,
count(case when comp_type = 'อัคคีภัย' then 1 end) as WINASAUSKEPAEI,
count(case when comp_type = 'ประกันเบ็ดเตล็ด' then 1 end) as WINASBETAREAD,
count(case when comp_type = 'อื่นๆ' then 1 end) as WINASETC

FROM PPMS_T_COMPLAINT COMPLAINT 
LEFT JOIN PPMS_T_DEPARTMENT DEPARTMENT ON COMPLAINT.DEPARTMENT_ID = DEPARTMENT.ID
LEFT JOIN "user" userid on COMPLAINT.ASSIGNED_USER_ID = userid.ID 
where insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ'
and DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}
AND $X{IN,DEPARTMENT.name,department}
AND $X{IN,userid.id,Responsible_person}
group by to_char(DATE_OF_COMP, 'YYYY','nls_calendar=''Thai Buddha'' nls_date_language = Thai')
ORDER by to_char(DATE_OF_COMP, 'YYYY','nls_calendar=''Thai Buddha'' nls_date_language = Thai')