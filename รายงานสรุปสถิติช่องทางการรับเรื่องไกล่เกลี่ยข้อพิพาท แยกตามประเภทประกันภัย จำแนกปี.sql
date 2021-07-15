SELECT 
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
WHERE TO_CHAR(DATE_OF_COMP,'YYYY') between TO_CHAR($P{start_date_time},'YYYY') and TO_CHAR($P{end_date_time},'YYYY')
GROUP BY TO_CHAR(DATE_OF_COMP,'YYYY'),PPMS_T_MEDIATOR.MEDIATOR_CHANNEL
ORDER BY DATEYEAR, total DESC