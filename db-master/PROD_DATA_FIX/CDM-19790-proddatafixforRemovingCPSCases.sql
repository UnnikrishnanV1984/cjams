
/*
   Issue Description: CDM-19790
   Category/ Module  : Delete cps cases
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update caseassignment set enddate = now(), updatedon = now(), updatedby = 'CDM-19790' where caseassignmentid = 'fdc9edb7-f565-4028-a4f1-dcfa9325cf07';
update intakeservicerequest set activeflag = 0, updatedon = now(), updatedby = 'CDM-19790' where servicerequestnumber in (
2021060086263,2021077093084,2021014071523,20200216027273,211020122155) and activeflag = 1;