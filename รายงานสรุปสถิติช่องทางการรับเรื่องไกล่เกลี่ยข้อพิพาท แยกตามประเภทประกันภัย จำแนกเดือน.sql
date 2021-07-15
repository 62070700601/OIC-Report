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
count(PPMS_T_MEDIATOR.id) AS total,
NVL(PPMS_T_MEDIATOR.MEDIATOR_CHANNEL, 'ไม่ระบุช่องทาง') AS CHANNEL,
count (case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' AND COMP_TYPE = 'รถยนต์' then 1  end) as winas_car,
count (case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' AND COMP_TYPE = 'รถยนต์' then 1  end)*100/count(PPMS_T_MEDIATOR.id) AS winas_car_per,
(count (case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' then 1  end)) - (count (case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' AND COMP_TYPE = 'รถยนต์' then 1  end)) AS winas_noncar,
((count (case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' then 1  end)) - (count (case when INSUR_TYPE = 'ร้องเรียนประกันวินาศภัย' AND COMP_TYPE = 'รถยนต์' then 1  end)))*100/count(PPMS_T_MEDIATOR.id) AS winas_noncar_per,
count (case when INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' then 1  end) AS health,
count (case when INSUR_TYPE = 'ร้องเรียนประกันชีวิต/สุขภาพ' then 1  end)*100/count(PPMS_T_MEDIATOR.id) AS health_per,
count (case when INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' then 1  end) AS insurer,
count (case when INSUR_TYPE = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' then 1  end)*100/count(PPMS_T_MEDIATOR.id) AS insurer_per
from PPMS_T_MEDIATOR 
WHERE TO_CHAR(DATE_OF_COMP,'MM') between TO_CHAR($P{start_date_time},'MM') and TO_CHAR($P{end_date_time},'MM')
and TO_CHAR(DATE_OF_COMP,'YYYY') between TO_CHAR($P{start_date_time},'YYYY') and TO_CHAR($P{end_date_time},'YYYY')
GROUP BY TO_CHAR(DATE_OF_COMP,'YYYY'), TO_CHAR(DATE_OF_COMP,'MM'),PPMS_T_MEDIATOR.MEDIATOR_CHANNEL
ORDER BY DATEYEAR, DATEMONTH, total DESC