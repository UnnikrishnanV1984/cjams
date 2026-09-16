/*
   Issue Description: CJAMs-65693
   Category/ Module  : SSA Approval change
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update adoptioncaseagreementrate 
set isssaapproved = 0, updatedby='CJAMS-65693', updatedon=now() 
where adoptionagreementrateid ='b3328757-daf7-4889-9548-b78ace58949f' and activeflag = 1;


update adoptioncaseagreementrate 
set isssaapproved = 0, updatedby='CJAMS-65693', updatedon=now() 
where adoptionagreementrateid ='78bc04dd-d1c7-4afa-91bd-48e70b9325cc' and activeflag = 1;
