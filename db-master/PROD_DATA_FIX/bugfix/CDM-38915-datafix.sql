/* 
    Issue Description: CDM-38915
  Category/ Module: Persons
  Root cause: User request to remove the person card
  Fix provided : data fix provided to remove the person card
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update intakeservicerequestactor
set activeflag = 0, updatedby = 'CDM-38407', updatedon = now()
where intakeservicerequestactorid ='775266ab-5ec1-460d-910f-ea3c4a4d733b' and personid = '309a4149-9a2b-45d3-8033-16251e6e0ce7'
and activeflag = 1;

update  personroletype
set activeflag = 0,updatedby = 'CDM-38041',
	updatedon = now()
where activeflag = 1
and personroleid
in (select personroleid
from personrole
where intakeserviceid = 'dd1dbcc3-cc53-49c9-8a59-ef697ff2e800'
and personid ='309a4149-9a2b-45d3-8033-16251e6e0ce7'
and activeflag = 1
);

update personrole
set activeflag = 0,	updatedby = 'CDM-38407', updatedon = now()
where personid ='309a4149-9a2b-45d3-8033-16251e6e0ce7' and activeflag = 1 ;
    
update actor
set activeflag = 0,	updatedby = 'CDM-38407', updatedon = now()
where personid ='309a4149-9a2b-45d3-8033-16251e6e0ce7'
and actorid ='1a81de60-5212-4122-bed9-c8bf7b1ee0ce' and activeflag = 1 ;

update actorrelationship
set activeflag = 0,	updatedby = 'CDM-38407', updatedon = now()
where intakeservicerequestactorid ='775266ab-5ec1-460d-910f-ea3c4a4d733b' and activeflag = 1;

update cjams.personprogramarea 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36639'
	where personid = '309a4149-9a2b-45d3-8033-16251e6e0ce7'