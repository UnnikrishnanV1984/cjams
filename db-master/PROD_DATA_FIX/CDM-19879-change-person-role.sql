/*
   Issue Description: CDM-19879
   Category/ Module  : changing person role
   Root cause: user requeseted to change person role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update investigationmaltreatment i  set activeflag =0,updatedby = 'CDM-19879',updatedon =now()where investigationid ='aee38cd7-731d-4090-9618-60db95bbb8da';

update intakeservicerequestactor i set intakeservicerequestpersontypekey ='OTH',updatedby = 'CDM-19879',updatedon =now()
where intakeservicerequestactorid  = '7021be3c-4d0d-4445-ab4b-70cd88c94a2a'
and activeflag  = 1

