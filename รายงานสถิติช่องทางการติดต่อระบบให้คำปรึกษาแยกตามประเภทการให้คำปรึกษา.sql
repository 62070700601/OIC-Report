SELECT 
count(PPMS_T_CONSULT.id),
PPMS_T_DEPARTMENT.NAME AS department,
PPMS_T_CONSULT.TYPE, 
count (case when PPMS_T_CONSULT.channel = 'ยื่นเรื่อง ณ สำนักงาน คปภ.' then 1  end) as oic,
count (case when PPMS_T_CONSULT.channel = 'ยื่นเรื่อง ณ สำนักงาน คปภ.' then 1  end)*100/count(PPMS_T_CONSULT.id) as oic_per,
count (case when PPMS_T_CONSULT.channel = 'หน่วยงานอื่น' then 1  end) as other,
count (case when PPMS_T_CONSULT.channel = 'หน่วยงานอื่น' then 1  end)*100/count(PPMS_T_CONSULT.id) as other_per,
count (case when PPMS_T_CONSULT.channel = 'อีเมล' then 1  end) as from_email,
count (case when PPMS_T_CONSULT.channel = 'อีเมล' then 1  end)*100/count(PPMS_T_CONSULT.id) as mail_per,
count (case when PPMS_T_CONSULT.channel = 'เว็บไซต์' then 1  end) as from_web,
count (case when PPMS_T_CONSULT.channel = 'เว็บไซต์' then 1  end)*100/count(PPMS_T_CONSULT.id) as web_per,
count (case when PPMS_T_CONSULT.channel = 'จดหมาย' then 1  end) as from_letter,
count (case when PPMS_T_CONSULT.channel = 'จดหมาย' then 1  end)*100/count(PPMS_T_CONSULT.id) as letter_per
from PPMS_T_CONSULT
LEFT JOIN PPMS_T_DEPARTMENT ON PPMS_T_CONSULT.DEPARTMENT_ID = PPMS_T_DEPARTMENT.ID
where DATE_OF_CONSULT between $P{start_date_time} and $P{end_date_time}
and $X{IN,PPMS_T_DEPARTMENT.NAME,department}
and PPMS_T_CONSULT.DEPARTMENT_ID IS NOT NULL
AND PPMS_T_CONSULT.TYPE IS NOT NULL 
group by PPMS_T_DEPARTMENT.NAME, PPMS_T_CONSULT.TYPE
order by PPMS_T_DEPARTMENT.NAME, count(PPMS_T_CONSULT.id) DESC