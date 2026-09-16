
/*
-- Issue Description:CDM-35062
-- Category/ Module: SDM
-- Fix Provided: Datafix to remove the physical abuse value selected and select the neglect 
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservicerequestsdm 
set isnoimmed_neglectresponse =true,
isnoimmed_physicalabuse =false,
updatedby='CDM-35062',
updatedon =now()
 where intakeserviceid ='5f28c9ad-ef83-4a59-80e1-b0db20407149' 
 and intakeservicerequestsdmid ='f5569c0d-851d-4f61-a4a6-48f98c9c74fc';
