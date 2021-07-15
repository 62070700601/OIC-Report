SELECT INSUR_TYPE,COUNT(INSUR_TYPE) AS COUNTTYPE ,
count(case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' then 1 end) RONGRENGPAKARNWINAS,
count(case when INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' then 1 end) RONGRENGPAKARNCHEVIT,
count(case when INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' then 1 end) RONGRENGNAINA,
count(case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE = 'รถยนต์' then 1 end) PAKARNWINAS_CAR,
count(case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE = 'ทะเล' then 1 end) PAKARNWINAS_SEA,
count(case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE = 'ขนส่ง' then 1 end) PAKARNWINAS_TRANSPORATION,
count(case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE = 'กรมธรรม์ความเสี่ยงภัยทรัพย์สิน (IAR)' then 1 end) PAKARNWINAS_IAR,
count(case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE = 'อุบัติเหตุส่วนบุคคล (PA)' then 1 end) PAKARNWINAS_PA,
count(case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE = 'กรมธรรม์ประกันสุขภาพ' then 1 end) PAKARNWINAS_SUKKAPAPR,
count(case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE = 'อัคคีภัย' then 1 end) PAKARNWINAS_AUKKEPAEI,
count(case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE = 'ประกันเบ็ดเตล็ด' then 1 end) PAKARNWINAS_BETAREDI,
count(case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' and COMP_TYPE = 'ประกันเบ็ดเตล็ด' then 1 end) PAKARNWINAS_ETC,
count(case when INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMP_TYPE = 'กรมธรรม์ประกันชีวิต' then 1 end) PAKARNCHEVIT_CHEVIT,
count(case when INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMP_TYPE = 'สัญญาประกันสุขภาพ' then 1 end) PAKARNCHEVIT_CONTACT,
count(case when INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMP_TYPE = 'ประกันอุบัติเหตุ' then 1 end) PAKARNCHEVIT_ACCIDENT,
count(case when INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMP_TYPE = 'อื่นๆ' then 1 end) PAKARNCHEVIT_ETC,
count(case when INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMP_TYPE = 'ตัวแทนประกันชีวิต (บุคคลธรรมดา)' then 1 end) NAINA_BEHALFPAKARNCHEVIT,
count(case when INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMP_TYPE = 'นายหน้าประกันชีวิต (บุคคลธรรมดา)' then 1 end) NAINA_NAINAPAKARNCHEVIT,
count(case when INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMP_TYPE = 'นายหน้าประกันชีวิต (นิติบุคคล)' then 1 end) NAINA_PAKARNCHEVITNITI,
count(case when INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMP_TYPE = 'ตัวแทนประกันวินาศภัย (บุคคลธรรมดา)' then 1 end) NAINA_BEHALFPAKARMWINAS,
count(case when INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMP_TYPE = 'นายหน้าประกันวินาศภัย (บุคคลธรรมดา)' then 1 end) NAINA_NAINAPAKARMWINAS,
count(case when INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMP_TYPE = 'นายหน้าประกันวินาศภัย (นิติบุคคล)' then 1 end) NAINA_PAKARMWINASNITI,
count(case when INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMP_TYPE = 'อื่นๆ' then 1 end) NAINA_ETC
FROM PPMS_T_COMPLAINT COMPLAINT 
LEFT JOIN PPMS_T_DEPARTMENT DEPARTMENT ON COMPLAINT.DEPARTMENT_ID = DEPARTMENT.ID
LEFT JOIN "user" userid on COMPLAINT.ASSIGNED_USER_ID = userid.ID 
where DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}
AND $X{IN,DEPARTMENT.name,department}
AND $X{IN,userid.id,Responsible_person}
GROUP BY INSUR_TYPE
ORDER BY INSUR_TYPE