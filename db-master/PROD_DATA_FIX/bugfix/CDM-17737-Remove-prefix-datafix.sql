/*
   Issue Description: CDM-17737 - Person profile prefix to be deleted
   -- CASE #: 3160515 -- CJAMSPID : 2179378
   Category/ Module  : Person profile
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
select 	activeflag, prefx, personid, cjamspid, *
from 	person 
where 	personid = 'f2b6f4df-4ee6-4202-b263-504e985649ad';

update 	person 
set 	prefx = null, 
		updatedby = 'CDM-17737', 
		updatedon = now()
where 	personid = 'f2b6f4df-4ee6-4202-b263-504e985649ad' and activeflag = 1;