/*
   Issue Description: CDM-23371
   Category/ Module  :  case 
   Root cause: soft deleted case by another defect fix by dev  CDM-22323.
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

update cjams.intakeservicerequest set activeflag =1, updatedby ='CDM-23371', updatedon =now() where intakeserviceid ='5512f719-f8a1-4af2-9239-2dc1958eddf5';