/*
-- CDM-22799- 

-- Issue Description: 
 Unable to remove duplicate persons
  
-- Customer Email ID: rosa.barrientos@montgomerycountymd.gov

-- Root cause: Data fix to remove duplicate persons
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update actor set activeflag = 0,updatedby = 'CDM-22799',updatedon = now()
where  actorid in ('ab14db7e-1cbe-4088-b9c1-ed64817ea7cf','7d480e78-bcf2-4a53-be91-bc9416815d14') and activeflag = 1;

update actorrelationship set activeflag = 0,updatedby = 'CDM-22799',updatedon = now()
where  actorrelationshipid in ('82a94389-4e7b-4705-9707-a56225e7a28c',
'526cf9e2-1567-4b3c-834d-8613d6620c5f') and activeflag = 1;


update personrole set activeflag = 0,updatedby = 'CDM-22799',updatedon = now()
where personroleid in ('87a660ad-2bb5-407b-a6a7-0c1771ae880a'
,'c8eb2547-5c52-4e1f-a499-d990fe7d72a5') and activeflag = 1;

update intakeservicerequestactor set activeflag = 0,updatedby = 'CDM-22799',updatedon = now()
where  intakeservicerequestactorid in ('44ab0149-b8f6-4ab7-9b03-7f267e55a5a2','d11d477f-9449-4d89-ad52-53f15085033a');