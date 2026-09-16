--Hot Fix for Provider Maltreatment Values mapping issues datafix

--CDM-38655

select isproviderinvolved from investigationallegation where investigationid ='392f4e7a-b224-4ddb-bc59-d0e343010350';

UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38655',
updatedon=now()
WHERE investigationid='392f4e7a-b224-4ddb-bc59-d0e343010350';

update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38655'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='392f4e7a-b224-4ddb-bc59-d0e343010350' and 
	im.maltreatmentid = improviderswitchinfo.objectid;
