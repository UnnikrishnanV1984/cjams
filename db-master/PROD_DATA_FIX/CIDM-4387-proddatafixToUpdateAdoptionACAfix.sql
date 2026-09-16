/*
   Issue Description: CIDM-4387
   Category/ Module  : Prod data fix to Update IVE Status for ACA
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptionapplicabilityinfo set activeflag = 0,updatedby = 'CIDM-4837', updatedon= now()
where adoptionapplicabilityid = 'b4e3b6c1-5bb6-42a3-8921-730ba38a83a8';

-- Review
update adoptionapplicabilityinfo set ivestatus = 'APPROVED',updatedby = 'CIDM-4837', updatedon= now()
where adoptionapplicabilityid = '187ed128-6a09-4e89-ae70-63f7a8d65ffa';