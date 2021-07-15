SELECT 
TO_CHAR(DATE_OF_COMP,'YYYY') as DATEYEAR,
TO_CHAR(DATE_OF_COMP,'YYYY') + 543 AS thaiyear,
count(PPMS_T_MEDIATOR.ID) AS total,
DISPUTE_ISSUE
FROM PPMS_T_MEDIATOR
where TO_CHAR(DATE_OF_COMP,'MM') between TO_CHAR($P{start_date_time},'MM') and TO_CHAR($P{end_date_time},'MM')
and TO_CHAR(DATE_OF_COMP,'YYYY') between TO_CHAR($P{start_date_time},'YYYY') and TO_CHAR($P{end_date_time},'YYYY')
and $X{IN,DISPUTE_ISSUE,dispute_issue}
GROUP BY TO_CHAR(DATE_OF_COMP,'YYYY'),DISPUTE_ISSUE
order by DATEYEAR, total DESC