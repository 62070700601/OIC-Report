SELECT COMPLAINT.status,count(COMPLAINT.status) as countstatus,
-- วินาศรถยนต์
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'รับเรื่อง' and COMPLAINT.COMP_TYPE = 'รถยนต์'  then 1  end) as Rongreng_rubreng_car ,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'มอบหมายงาน' and COMPLAINT.COMP_TYPE = 'รถยนต์'  then 1  end) as Rongreng_handover_car,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'กำลังดำเนินการ' and COMPLAINT.COMP_TYPE = 'รถยนต์'  then 1  end) as Rongreng_continue_car,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'รอเอกสาร/หลักฐาน' and COMPLAINT.COMP_TYPE = 'รถยนต์'  then 1  end) as Rongreng_waitting_car,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'ยุติ'  and COMPLAINT.COMP_TYPE = 'รถยนต์' then 1  end) as Rongreng_yuti_car,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'ยุติ ISC' and COMPLAINT.COMP_TYPE = 'รถยนต์'  then 1  end) as Rongreng_yutiISC_car,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS in ('ส่งเรื่องไปไกล่เกลี่ยข้อพิพาท','ส่งเรื่องไปอนุญาโตตุลาการ') and COMPLAINT.COMP_TYPE = 'รถยนต์'  then 1  end) as WINASCAR_ALLCONVERTED,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'ส่งเรื่องไปไกล่เกลี่ยข้อพิพาท' and COMPLAINT.COMP_TYPE = 'รถยนต์'  then 1  end) as WINASCAR_KAIKEARPIPAD,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'ส่งเรื่องไปอนุญาโตตุลาการ' and COMPLAINT.COMP_TYPE = 'รถยนต์'  then 1  end) as WINASCAR_ANUYATOR,


-- วินาศไม่รถยนต์
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'รับเรื่อง' and COMPLAINT.COMP_TYPE != 'รถยนต์'  then 1  end) as Rongreng_rubreng ,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'มอบหมายงาน' and COMPLAINT.COMP_TYPE != 'รถยนต์'  then 1  end) as Rongreng_handover,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'กำลังดำเนินการ' and COMPLAINT.COMP_TYPE != 'รถยนต์'  then 1  end) as Rongreng_continue,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'รอเอกสาร/หลักฐาน' and COMPLAINT.COMP_TYPE != 'รถยนต์'  then 1  end) as Rongreng_waitting,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'ยุติ'  and COMPLAINT.COMP_TYPE != 'รถยนต์' then 1  end) as Rongreng_yuti,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'ยุติ ISC' and COMPLAINT.COMP_TYPE != 'รถยนต์'  then 1  end) as Rongreng_yutiISC,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS in ('ส่งเรื่องไปไกล่เกลี่ยข้อพิพาท','ส่งเรื่องไปอนุญาโตตุลาการ') and COMPLAINT.COMP_TYPE != 'รถยนต์'  then 1  end) as WINASNOTCAR_ALLCONVERTED,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'ส่งเรื่องไปไกล่เกลี่ยข้อพิพาท' and COMPLAINT.COMP_TYPE != 'รถยนต์'  then 1  end) as WINASNOTCAR_KAIKERAR,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันวินาศภัย' and COMPLAINT.STATUS = 'ส่งเรื่องไปอนุญาโตตุลาการ' and COMPLAINT.COMP_TYPE != 'รถยนต์'  then 1  end) as WINASNOTCAR_ANUYATOR,




count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMPLAINT.STATUS = 'รับเรื่อง' then 1  end) as Pakarnchevit_rubreng ,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMPLAINT.STATUS = 'มอบหมายงาน' then 1  end) as Pakarnchevit_handover,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMPLAINT.STATUS = 'กำลังดำเนินการ' then 1  end) as Pakarnchevit_continue,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMPLAINT.STATUS = 'รอเอกสาร/หลักฐาน' then 1  end) as Pakarnchevit_waitting,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMPLAINT.STATUS = 'ยุติ' then 1  end) as Pakarnchevit_yuti,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMPLAINT.STATUS = 'ยุติ ISC' then 1  end) as Pakarnchevit_yutiISC,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMPLAINT.STATUS in ('ส่งเรื่องไปไกล่เกลี่ยข้อพิพาท','ส่งเรื่องไปอนุญาโตตุลาการ') then 1  end) as PAKARNCHEVIT_ALLCONVERTED,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMPLAINT.STATUS = 'ส่งเรื่องไปไกล่เกลี่ยข้อพิพาท' then 1  end) as PAKARNCHEVIT_KAIKEAR,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนประกันชีวิต/สุขภาพ' and COMPLAINT.STATUS = 'ส่งเรื่องไปอนุญาโตตุลาการ' then 1  end) as PAKARNCHEVIT_ANUYATOR,


count (case when  COMPLAINT.insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMPLAINT.STATUS = 'รับเรื่อง' then 1  end) as Naina_rubreng ,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMPLAINT.STATUS = 'มอบหมายงาน' then 1  end) as Naina_handover,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMPLAINT.STATUS = 'กำลังดำเนินการ' then 1  end) as Naina_continue,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMPLAINT.STATUS = 'รอเอกสาร/หลักฐาน' then 1  end) as Naina_waitting,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMPLAINT.STATUS = 'ยุติ' then 1  end) as Naina_yuti,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMPLAINT.STATUS = 'ยุติ ISC' then 1  end) as Naina_yutiISC,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMPLAINT.STATUS in ('ส่งเรื่องไปไกล่เกลี่ยข้อพิพาท','ส่งเรื่องไปอนุญาโตตุลาการ') then 1  end) as NAINA_ALLCONVERTED,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMPLAINT.STATUS = 'ส่งเรื่องไปไกล่เกลี่ยข้อพิพาท'then 1  end) as NAINA_KAIKEAR,
count (case when  COMPLAINT.insur_type = 'ร้องเรียนตัวแทนหรือนายหน้า ประกันชีวิต/วินาศภัย' and COMPLAINT.STATUS = 'ส่งเรื่องไปอนุญาโตตุลาการ' then 1  end) as NAINA_ANUYATOR



FROM PPMS_T_COMPLAINT COMPLAINT 
LEFT JOIN PPMS_T_DEPARTMENT DEPARTMENT ON COMPLAINT.DEPARTMENT_ID = DEPARTMENT.ID
LEFT JOIN "user" userid on COMPLAINT.ASSIGNED_USER_ID = userid.ID 
where COMPLAINT.status is not null 
 and DATE_OF_COMP between $P{start_date_time} and  $P{end_date_time}
AND $X{IN,DEPARTMENT.name,department}
AND $X{IN,userid.id,Responsible_person} 
GROUP BY COMPLAINT.status
ORDER BY COMPLAINT.status