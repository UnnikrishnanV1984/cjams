-- CDM-38679 - Maltreatment allegation is not checked off
/*
-- Issue Description: 
   241021916896:This case is showing it is a provider maltreatment case in the Maltreatment 
   allegations tab. This was not previously showing until I completed the maltreatment tab. 
   This case will be closing in the next 24 hours.SDM is correct and provider maltreatment 
   is not checked off
   
-- Category/ Module: Maltreatment-Allegation 
-- Root cause: Maltreatment allegation is not checked off where it is correct in SDM  
-- Fix Provided: Data fix to change the provider involved maltreatment from Yes to No and remove the reason for change. */


--CDM-38679

UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38679',
updatedon=now()
WHERE investigationid='08f57f84-fdcd-4315-912f-c3e71917e559';

update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38679'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='08f57f84-fdcd-4315-912f-c3e71917e559' and 
	im.maltreatmentid = improviderswitchinfo.objectid;