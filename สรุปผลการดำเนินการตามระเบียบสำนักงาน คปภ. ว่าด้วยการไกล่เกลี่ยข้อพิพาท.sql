SELECT 
INSUR_TYPE,
CASE
    WHEN INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' THEN 'ประกันวินาศภัย'
    WHEN INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' THEN 'ประกันชีวิต/สุขภาพ'
    WHEN INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' THEN 'ตัวแทนหรือนายหน้า'   
END as insure_type_it,
count(PPMS_T_MEDIATOR.ID) AS total,
count (case when PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'ใหม่' OR 
PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'รับเรื่อง' OR 
PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'มอบหมายงาน' OR 
PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'กำลังดำเนินการ' OR 
PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'รอเอกสาร/หลักฐาน' OR 
PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'นัดหมายไกล่เกลี่ย' OR 
PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'เสนอแต่งตั้งผู้ไกล่เกลี่ย' OR 
PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'อยู่ระหว่างไกล่เกลี่ยข้อพิพาท' then 1  end) as on_process,
count (case when PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'ยุติข้อพิพาท/ทำบันทึกความตกลงประนีประนอมยอมความแล้ว' OR PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'ผู้ร้องถอนเรื่อง' then 1  end) as done_finished,
count (case when PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'ไม่สามารถตกลงยุติข้อพิพาทได้' then 1  end) AS done_unfinished,
count (case when PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'ยุติข้อพิพาท/ทำบันทึกความตกลงประนีประนอมยอมความแล้ว' OR 
PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'ไม่สามารถตกลงยุติข้อพิพาทได้' OR PPMS_T_MEDIATOR.MEDIATOR_STATUS = 'ผู้ร้องถอนเรื่อง' then 1  end) AS all_done
FROM PPMS_T_MEDIATOR
where DATE_OF_COMP between $P{start_date_time} and $P{end_date_time}
GROUP BY INSUR_TYPE
ORDER BY INSUR_TYPE desc, total DESC