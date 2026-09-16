/*
   Issue Description: CDM-28796
   Category/ Module  : Prod data fix to the removal
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


UPDATE cjams.intakeservicerequestdispositioncode
SET updatedby='CDM-28796', updatedon=now(), servicerequesttypeconfigiddispostionid = '4c6d4e10-5572-4cb0-8bd0-5d596e3e2588',
intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690'
WHERE intakeservicerequestdispositioncodeid ='6109a1f6-480d-4faa-850c-ea6fb62ffa26' and intakeserviceid='54b6d747-13f8-4188-bf18-be74d177eb00';

update intakeservicerequest set 
description ='Approved', 
intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= NOW(), updatedby='CDM-28796'
where intakeserviceid='54b6d747-13f8-4188-bf18-be74d177eb00';

UPDATE cjams.routing
SET routingstatustypeid=2, activeflag=1, updatedon=now()
WHERE routingid='bff63a29-ab61-4a58-9893-fd31809a1d28' and objectid='54b6d747-13f8-4188-bf18-be74d177eb00';


UPDATE cjams.caseassignment
SET updatedby='CDM-28796', updatedon=now(), enddate=null
WHERE caseassignmentid='a23e6695-3dc0-46f2-ac07-ed8776304c45' and objectid='54b6d747-13f8-4188-bf18-be74d177eb00';