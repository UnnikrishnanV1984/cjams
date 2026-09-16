-- CDM-38680- Maltreatment allegation is not checked off
/*
-- Issue Description: 
   241021919259:This is not and never was a provider maltreatment case. This error happened when I completed the maltreatment allegations. SDM shows correctly but maltreatment allegations show this is a provider case
   
-- Category/ Module: Maltreatment-Allegation 
-- Root cause: Maltreatment allegation is not checked off where it is correct in SDM  
-- Fix Provided: Data fix to change the provider involved maltreatment from Yes to No and remove the reason for change. */


--CDM-38680
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38680',
updatedon=now()
WHERE investigationid='145c4a00-a65f-416b-9908-0747625ac138';

update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38680'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='145c4a00-a65f-416b-9908-0747625ac138' and 
	im.maltreatmentid = improviderswitchinfo.objectid;