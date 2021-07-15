SELECT 
tr.alltotal,
count(PPMS_T_MEDIATOR.ID) AS total,
(count(PPMS_T_MEDIATOR.ID)*100)/tr.alltotal AS per,
INSUR_TYPE,
CASE
    WHEN INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' THEN 'ประกันวินาศภัย'
    WHEN INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' THEN 'ประกันชีวิต/สุขภาพ'
    WHEN INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' THEN 'ตัวแทนหรือนายหน้า'   
END as insure_type_it,
COMP_TYPE
FROM PPMS_T_MEDIATOR
CROSS JOIN (SELECT count(PPMS_T_MEDIATOR.ID) AS alltotal FROM PPMS_T_MEDIATOR where DATE_OF_COMP between $P{start_date_time} and $P{end_date_time} and $X{IN,INSUR_TYPE,insure_type}) tr
where DATE_OF_COMP between $P{start_date_time} and $P{end_date_time} 
and $X{IN,INSUR_TYPE,insure_type}
GROUP BY INSUR_TYPE, COMP_TYPE, tr.alltotal
order by INSUR_TYPE DESC, total DESC