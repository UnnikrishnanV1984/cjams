
/*
   Issue Description: CDM-28443
   Category/ Module  :  Duplicate intake delete
   Root cause: user requeseted to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placement 
set activeflag = 0,
	updatedby = 'CDM-28443',
	updatedon = now()
where placementid ='db176645-c511-41b6-9b94-660cbff3ae76' and activeflag ='1';

update livingarrangement 
set activeflag = 0,
   updatedby = 'CDM-28443', 
   updatedon = now()
where placementid ='db176645-c511-41b6-9b94-660cbff3ae76' and activeflag ='1';


update placement 
set activeflag = 0,
	updatedby = 'CDM-28443',
	updatedon = now()
where placementid ='8e0b2a3e-65bc-45d6-9a60-03acea49edd7' and activeflag ='1';

update livingarrangement 
set activeflag = 0,
   updatedby = 'CDM-28443', 
   updatedon = now()
where placementid ='8e0b2a3e-65bc-45d6-9a60-03acea49edd7' and activeflag ='1';

		
UPDATE routing 
SET activeflag = 0, updatedby = 'CDM-28443', updatedon = now() 
WHERE routingid = '7879d61e-078b-4275-9f00-28737072324c';

UPDATE routing 
SET activeflag = 0, updatedby = 'CDM-28443', updatedon = now() 
WHERE routingid = '6e3fac79-6b88-4123-9ff4-ecbe934f4ad6';

