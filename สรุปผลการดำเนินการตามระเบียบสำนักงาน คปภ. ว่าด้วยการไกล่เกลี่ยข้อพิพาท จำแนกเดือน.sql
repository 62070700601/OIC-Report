SELECT
TO_CHAR(DATE_OF_COMP,'MM') as DATEMONTH,
CASE
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 01 THEN 'มกราคม'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 02 THEN 'กุมภาพันธ์.'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 03 THEN 'มีนาคม'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 04 THEN 'เมษายน'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 05 THEN 'พฤษภาคม'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 06 THEN 'มิถุนายน'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 07 THEN 'กรกฎาคม'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 08 THEN 'สิงหาคม'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 09 THEN 'กันยายน'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 10 THEN 'ตุลาคม'
    WHEN TO_CHAR(DATE_OF_COMP,'MM') = 11 THEN 'พฤศจิกายน'
	WHEN TO_CHAR(DATE_OF_COMP,'MM') = 12 THEN 'ธันวาคม'    
END as monthfontthai,
TO_CHAR(DATE_OF_COMP,'YYYY') as DATEYEAR,
TO_CHAR(DATE_OF_COMP,'YYYY') + 543 AS thaiyear,
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
WHERE TO_CHAR(DATE_OF_COMP,'MM') between TO_CHAR($P{start_date_time},'MM') and TO_CHAR($P{end_date_time},'MM')
and TO_CHAR(DATE_OF_COMP,'YYYY') between TO_CHAR($P{start_date_time},'YYYY') and TO_CHAR($P{end_date_time},'YYYY')
GROUP BY TO_CHAR(DATE_OF_COMP,'YYYY'), TO_CHAR(DATE_OF_COMP,'MM'), INSUR_TYPE
ORDER BY DATEYEAR, DATEMONTH, INSUR_TYPE desc, total DESC