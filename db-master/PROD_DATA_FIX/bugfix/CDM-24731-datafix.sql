/*
   Issue Description: CDM-24731
   Category/ Module  : ChildRemoval
   Root cause: User wanted to remove the Removal End Date.
*/

select 	activeflag , removaldate, exitdate , personid,  removalid
from 	intakeservreqchildremoval 
where 	removalid = '188964' and activeflag = 1;

update 	intakeservreqchildremoval
set 	exitdate = null, 
		returndate = Null,
		returntime = Null,
		removalexitreason = NULL,
		updatedby = 'CDM-24731', 
		updatedon = now()
where 	removalid = '188964' and activeflag = 1;


select 	activeflag , startdate , enddate , personid, programkey
from 	personprogramarea 
where   personprogramid = '471d69f8-ec2a-4def-befc-bc5941d4ce21'
        and personid = '4f5ea99e-7e3b-424e-b7f1-d96a0f68d5e3'
        and programkey = 'OOH'
        and activeflag = 1;
        
update  personprogramarea
set     enddate = null,
        updatedby = 'CDM-24731', 
		updatedon = now()
where   personprogramid = '471d69f8-ec2a-4def-befc-bc5941d4ce21'
        and personid = '4f5ea99e-7e3b-424e-b7f1-d96a0f68d5e3'
        and programkey = 'OOH'
        and activeflag = 1;