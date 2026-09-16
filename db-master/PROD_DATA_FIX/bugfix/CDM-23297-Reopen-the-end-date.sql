/*
   Issue Description: CDM-23297
   Category/ Module  :  Placement
   Root cause: user requeseted to update placement Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CDM-23297' 
where placementid = 'cdfcf492-c38b-4c6f-b872-092e9c5358b2';


-- Update Removal

select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 191548
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-23297',
	updatedon = now()
where removalid = 191548
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'ad4cf394-3624-4d4e-babf-64ed6bc51944'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-23297',
	updatedon = now()
where personprogramid = 'ad4cf394-3624-4d4e-babf-64ed6bc51944'
	and activeflag = 1 ;