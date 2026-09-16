/*
 Issue Description:
 	2020032404314:Hospital discharge date and placement exit date should be 3/6/25.
 Category/ Module: Placement
 Root cause: 	User Error, Hospital discharge date and placement exit date should be 3/6/25.
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- Placement date changes
/*
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon,* 
from placement 
where placementid = '7ba60739-ddc5-421e-bce5-24a83dac8993'
	and activeflag  = 1 ; --2037452
*/

update placement  
set enddatetime = '2025-03-06 00:00:00.000', 
	updatedon = now(), 
	updatedby = 'CJAMS-58214'
where placementid = '7ba60739-ddc5-421e-bce5-24a83dac8993'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
/*
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '7ba60739-ddc5-421e-bce5-24a83dac8993' 
	and exitdate is not null ;
*/

update placementrevision  
set exitdate = '2025-03-06 00:00:00', 
	updatedon = now(), 
	updatedby = 'CJAMS-58214'
where placementid = '7ba60739-ddc5-421e-bce5-24a83dac8993' 
	and exitdate is not null ;

-- update discharge date
/*
select enddt,endtime,hospital_dischargeddate,* from personhospitalization where hospitalizationid = 'f116e98c-a2a3-4728-a75e-d0c3004e012d';
2023-12-01 10:00
*/

update personhospitalization 
set hospital_dischargeddate = '2025-03-06 16:00:00.000',
	updatedby = 'CJAMS-58214',
	updatedon = now()
where hospitalizationid = 'f116e98c-a2a3-4728-a75e-d0c3004e012d'
and activeflag = 1;