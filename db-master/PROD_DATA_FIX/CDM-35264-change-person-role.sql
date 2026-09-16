/*
   Issue Description: CDM-35264
   Category/ Module  : Person Role Issue (Persons: Household)
   Issue Description :  231011420653:Peyton LeBlanc (PID#200938672) has her role listed as alleged victim/child and this is INACCURATE. Role needs to be changed to Parent/Alleged maltreator
   Root cause: user requeseted to change person role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


select intakeservicerequestactorid,intakeservicerequestpersontypekey from intakeservicerequestactor where personid='c3092879-f513-4fb9-b984-7ecd9a40e09b' and activeflag=1 and intakenumber='I231011420653';

update intakeservicerequestactor i set intakeservicerequestpersontypekey ='AM',updatedby = 'CDM-35264',updatedon =now()
where intakeservicerequestactorid  = '0380947a-f950-42aa-bc7d-9891c9b1abc8'
and activeflag  = 1;

update intakeservicerequestactor i set intakeservicerequestpersontypekey ='PARENT',updatedby = 'CDM-35264',updatedon =now()
where intakeservicerequestactorid  = '8351c083-055f-4982-a03f-f0d5d067a3eb'
and activeflag  = 1;