SELECT 
count(PPMS_T_CONSULT.id),
PPMS_T_DEPARTMENT.NAME AS department,
count (case when PPMS_T_CONSULT.TYPE = 'รถยนต์ภาคบังคับ' then 1  end) as car_fix,
count (case when PPMS_T_CONSULT.TYPE = 'รถยนต์ภาคบังคับ' then 1  end)*100/count(PPMS_T_CONSULT.id) AS car_fix_per,
count (case when PPMS_T_CONSULT.TYPE = 'รถยนต์ภาคสมัครใจ' then 1  end) as car_flex,
count (case when PPMS_T_CONSULT.TYPE = 'รถยนต์ภาคสมัครใจ' then 1  end)*100/count(PPMS_T_CONSULT.id) AS car_flex_per,
count (case when PPMS_T_CONSULT.TYPE = 'ทะเล' then 1  end) as sea,
count (case when PPMS_T_CONSULT.TYPE = 'ทะเล' then 1  end)*100/count(PPMS_T_CONSULT.id) AS sea_per,
count (case when PPMS_T_CONSULT.TYPE = 'ขนส่ง' then 1  end) as transport,
count (case when PPMS_T_CONSULT.TYPE = 'ขนส่ง' then 1  end)*100/count(PPMS_T_CONSULT.id) AS transport_per,
count (case when PPMS_T_CONSULT.TYPE = 'อุบัติเหตุส่วนบุคคล (PA)' then 1  end) as pa,
count (case when PPMS_T_CONSULT.TYPE = 'อุบัติเหตุส่วนบุคคล (PA)' then 1  end)*100/count(PPMS_T_CONSULT.id) AS pa_per,
count (case when PPMS_T_CONSULT.TYPE = 'สัญญาการประกันสุขภาพ' then 1  end) as health,
count (case when PPMS_T_CONSULT.TYPE = 'สัญญาการประกันสุขภาพ' then 1  end)*100/count(PPMS_T_CONSULT.id) AS health_per,
count (case when PPMS_T_CONSULT.TYPE = 'อัคคีภัย' then 1  end) as fire,
count (case when PPMS_T_CONSULT.TYPE = 'อัคคีภัย' then 1  end)*100/count(PPMS_T_CONSULT.id) AS fire_per,
count (case when PPMS_T_CONSULT.TYPE = 'กรมธรรม์ประกันภัยความเสี่ยงภัยทุกชนิด IAR' then 1  end) as iar,
count (case when PPMS_T_CONSULT.TYPE = 'กรมธรรม์ประกันภัยความเสี่ยงภัยทุกชนิด IAR' then 1  end)*100/count(PPMS_T_CONSULT.id) AS iar_per,
count (case when PPMS_T_CONSULT.TYPE = 'อื่นๆ' then 1  end) as etc,
count (case when PPMS_T_CONSULT.TYPE = 'อื่นๆ' then 1  end)*100/count(PPMS_T_CONSULT.id) AS etc_per
from PPMS_T_CONSULT
LEFT JOIN PPMS_T_DEPARTMENT ON PPMS_T_CONSULT.DEPARTMENT_ID = PPMS_T_DEPARTMENT.ID
where DATE_OF_CONSULT between $P{start_date_time} and $P{end_date_time}
and $X{IN,PPMS_T_DEPARTMENT.name,department}
and PPMS_T_DEPARTMENT.name is not null
group by PPMS_T_DEPARTMENT.NAME
order by PPMS_T_DEPARTMENT.NAME