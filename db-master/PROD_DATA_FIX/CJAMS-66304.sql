/*
   Issue Description: CJAMS-66304
   Category/ Module  :  Requested to change the maltreator information under sdm
   Root Cause: User Wants to change the provider involved maltreatment radio from Yes to No in SDM
   Fix provided: Data fix has been done by updating the provider involved maltreatment radio from Yes to No in SDM
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/

update intakeservicerequestsdm 
set ismaltreatment = false, updatedby ='CJAMS-66304', updatedon =now()
where intakeservicerequestsdmid ='a8293443-5e96-46c8-8f3d-72b804657280' and activeflag =1;