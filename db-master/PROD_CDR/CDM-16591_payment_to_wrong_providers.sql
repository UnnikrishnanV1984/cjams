/*
   Issue Description: CDM-16591
   Category/ Module  : User wants to reopen a case
   Root cause:userfilled it by mistake
   Pull request# for code fix: 
   Explanantion: user wants to reopen a case and remove the exisiting case to ignore payments to wrong providers
*/

select vpaenddate ,removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag , *
	from cjams.intakeservreqchildremoval
where personid  = 'a2a720b0-43ae-4bde-814f-efdff0358b34'
and removalid  = '196328'
	and activeflag = 1 ;

update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-16591',
	updatedon = now()
where removalid  = '196328'
	and activeflag = 1 ;

select programkey, startdate, enddate, updatedby, updatedon, *
	from cjams.personprogramarea 
where personprogramid  = '37e7c799-4daf-4486-859b-e4ae0f8fb581'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-16591',
	updatedon = now()
where personprogramid  = '37e7c799-4daf-4486-859b-e4ae0f8fb581'
	and activeflag = 1 ;
