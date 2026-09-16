/*
   Issue Description: CDM-26587
   Category/ Module  : new service case
   Root cause: user wants to create new case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.routing set routingstatustypeid = 2, updatedby = 'CDM-26587', updatedon = now() 
where routingid ='6da4fd75-b63e-4865-b7e3-86063f31bd02';

update intakeservicerequest
set actiontype = 'AR', intakeservicerequestclassid = 'b74ded78-12dc-4e6d-94db-7662d6eaf093',
IntakeSerReqStatusTypeId = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
reporteddate = to_timestamp('2022-11-14 09:00:00', 'YYYY-MM-DD HH23:MI:SS' ),
servicecaseid = null, activeflag = 1,
updatedon = now(), updatedby = 'CDM-26587'
where intakeserviceid= '1b79cac1-8b2b-46c0-8f22-c0e534a7992d';

update IntakeServiceRequestDispositionCode
set IntakeSerReqStatusTypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
updatedon = now(), updatedby = 'CDM-26587'
where  intakeserviceid = '1b79cac1-8b2b-46c0-8f22-c0e534a7992d';

update servicerequesttypeconfigdispositioncode
set description = 'Screen In', dispositioncode = 'Scrnin',
updatedon = now(), updatedby = 'CDM-26587'
where ServiceRequestTypeConfigIdDispostionId = '94377120-38d7-461a-932f-457c3ef723ca';

