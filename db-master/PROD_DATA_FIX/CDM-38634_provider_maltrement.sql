--Hot Fix for Provider Maltreatment Values mapping issues datafix

--CDM-38634


UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38634',
updatedon=now()
WHERE investigationid='f501d0b1-3d86-4a8f-b876-aef0939cd03d';

update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38634'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='f501d0b1-3d86-4a8f-b876-aef0939cd03d' and 
	im.maltreatmentid = improviderswitchinfo.objectid;
