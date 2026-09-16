/*
  Issue Description: CDM-25357
   Category/ Module  : Case reopen
   Root cause: user wanted to add correction to closed case
   Pull request# for code fix: 7403
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/

update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= NOW(), updatedby='CDM-25357'
where intakeserviceid = 'e7f63cbe-a936-424a-a5ed-9b080c679431';

update intakeservicerequestdispositioncode set activeflag = 0, updatedon= NOW(), updatedby='CDM-25357' where intakeservicerequestdispositioncodeid  = 'e3668c61-dab3-4e53-a17c-87ddbc1e4ee2';

update Investigationmaltreatment 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-25357' 
where maltreatmentid  = '5bcdb7d1-bb05-4479-aa5d-773d079badec';

update investigationmaltreatmentactor 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-25357' 
where maltreatmentid  = '5bcdb7d1-bb05-4479-aa5d-773d079badec';

update investigationallegation set activeflag = 0, updatedon = now(),
updatedby = 'CDM-25357'
where investigationallegationid = 'b53a95d6-742a-49c3-9912-44c21df8f829';
 