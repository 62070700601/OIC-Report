SELECT channel,count(channel) AS countchannel,
-- วินาศรถยนต์
count (case when  insur_type = 'ร้องเรียนประกันวินาศภัย' and channel = 'ยื่นเรื่อง ณ สำนักงาน คปภ.' and COMP_TYPE = 'รถยนต์' then 1  end) as Rongreng_yengreng_car,
count (case when  insur_type = 'ร้องเรียนประกันวินาศภัย' and channel = 'เว็บไซต์' and COMP_TYPE = 'รถยนต์' then 1  end) as Rongreng_website_car,
count (case when  insur_type = 'ร้องเรียนประกันวินาศภัย' and channel = 'อีเมล' and COMP_TYPE = 'รถยนต์' then 1  end) as Rongreng_email_car,
count (case when  insur_type = 'ร้องเรียนประกันวินาศภัย' and channel = 'จดหมาย' and COMP_TYPE = 'รถยนต์' then 1  end) as Rongreng_letter_car,
count (case when  insur_type = 'ร้องเรียนประกันวินาศภัย' and channel = 'หน่วยงานอื่น' and COMP_TYPE = 'รถยนต์' then 1  end) as Rongreng_etc_car,
-- วินาศไม่รถยนต์
count (case when  insur_type = 'ร้องเรียนประกันวินาศภัย' and channel = 'ยื่นเรื่อง ณ สำนักงาน คปภ.' and COMP_TYPE != 'รถยนต์' then 1  end) as Rongreng_yengreng,
count (case when  insur_type = 'ร้องเรียนประกันวินาศภัย' and channel = 'เว็บไซต์' and COMP_TYPE != 'รถยนต์' then 1  end) as Rongreng_website,
count (case when  insur_type = 'ร้องเรียนประกันวินาศภัย' and channel = 'อีเมล' and COMP_TYPE != 'รถยนต์' then 1  end) as Rongreng_email,
count (case when  insur_type = 'ร้องเรียนประกันวินาศภัย' and channel = 'จดหมาย' and COMP_TYPE != 'รถยนต์' then 1  end) as Rongreng_letter,
count (case when  insur_type = 'ร้องเรียนประกันวินาศภัย' and channel = 'หน่วยงานอื่น' and COMP_TYPE != 'รถยนต์' then 1  end) as Rongreng_etc,
-- 2  
count (case when  insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and channel = 'ยื่นเรื่อง ณ สำนักงาน คปภ.' then 1  end) as Pakarnchevit_yengreng ,
count (case when  insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and channel = 'เว็บไซต์' then 1  end) as Pakarnchevit_website,
count (case when  insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and channel = 'อีเมล' then 1  end) as Pakarnchevit_email,
count (case when  insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and channel = 'จดหมาย' then 1  end) as Pakarnchevit_letter,
count (case when  insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and channel = 'หน่วยงานอื่น' then 1  end) as Pakarnchevit_etc,
-- 3
count (case when  insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and channel = 'ยื่นเรื่อง ณ สำนักงาน คปภ.' then 1  end) as Naina_yengreng,
count (case when  insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and channel = 'เว็บไซต์' then 1  end) as Naina_website,
count (case when  insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and channel = 'อีเมล' then 1  end) as Naina_email,
count (case when  insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and channel = 'จดหมาย' then 1  end) as Naina_letter,
count (case when  insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and channel = 'หน่วยงานอื่น' then 1  end) as Naina_etc
FROM PPMS_T_COMPLAINT COMPLAINT 
LEFT JOIN PPMS_T_DEPARTMENT DEPARTMENT ON COMPLAINT.DEPARTMENT_ID = DEPARTMENT.ID
LEFT JOIN "user" userid on COMPLAINT.ASSIGNED_USER_ID = userid.ID 

where channel is not null and 
 DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}
 AND $X{IN,DEPARTMENT.name,department}
AND $X{IN,userid.id,Responsible_person}
GROUP BY channel
ORDER BY channel