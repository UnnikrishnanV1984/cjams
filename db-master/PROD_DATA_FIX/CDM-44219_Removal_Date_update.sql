/*
   Issue Description: CDM-44219
   Category/ Module  : OOH, childremoval
   Root cause: remove: User Error, wrong removal date that need to be changed to 11-19-2024
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/ 

-- Removal date changes
/*
select removaldate, exitdate, returndate, updatedby, updatedon,*
	from cjams.intakeservreqchildremoval 
where intakeservreqchildremovalid = '3c836887-2f78-4d11-a0f2-c48005522525'
	and activeflag = 1 ;
*/
/*
update cjams.intakeservreqchildremoval
set exitdate  = '2024-11-19 09:00:00.000',
	updatedby = 'CDM-44219',
	updatedon = now()
where intakeservreqchildremovalid = '3c836887-2f78-4d11-a0f2-c48005522525'
	and activeflag = 1 ;
*/

/*
--objectid: 41549099-50fc-4d5b-9f08-1e0b46f75832
-- OOH End date changes
select personid, programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'd1c53a0d-60de-4b4e-89ed-a64d55da6d84'
	and activeflag = 1 ;
*/

update cjams.personprogramarea
set enddate  = '2024-11-19 00:00:00',
	updatedby = 'CDM-44219',
	updatedon = now()
where personprogramid = 'd1c53a0d-60de-4b4e-89ed-a64d55da6d84'
	and activeflag = 1 ;
