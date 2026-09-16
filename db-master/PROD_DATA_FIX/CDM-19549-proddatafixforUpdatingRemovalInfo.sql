
/*
   Issue Description: CDM-19549
   Category/ Module  : Updating Child Removal agencysigneddate
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval i set agencysigneddate = '2021-02-11 00:00:00', updatedby = 'CDM-19549', updatedon = now where intakeservreqchildremovalid = '562614d1-77a9-4eec-9914-c00e9942174b';
