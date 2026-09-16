--Hot Fix for Provider Maltreatment Values mapping issues datafix

--CDM-38688

select isproviderinvolved from investigationallegation where investigationid ='4f111811-11e6-416c-95df-58b91e8fa237';

UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38688',
updatedon=now()
WHERE investigationid='4f111811-11e6-416c-95df-58b91e8fa237';

update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38688'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='4f111811-11e6-416c-95df-58b91e8fa237' and 
	im.maltreatmentid = improviderswitchinfo.objectid;
