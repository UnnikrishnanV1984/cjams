
/*
-- Issue Description:CDM-35907
-- Category/ Module: SDM
-- Fix Provided: Datafix to remove the physical abuse value selected and select the neglect 
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservicerequestsdm 
set isnoimmed_neglectresponse =true,
isnoimmed_physicalabuse =false,
updatedby='CDM-35907',
updatedon =now()
 where intakeserviceid ='b48815e4-5ab2-4e10-beb7-a717f4de5440' 
 and intakeservicerequestsdmid ='c967adc8-2454-49c1-97db-55d066673130';