/*
   Issue Description: CDM-23212
   Category/ Module  : Removal type 
   Root cause: user wants to change removal type from Children With Disabilities Voluntary Placement to Judicial Determination
   Pull request# for code fix: 5730
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update intakeservreqchildremoval 
set removaltypekey = 'JD', updatedon = now(), updatedby = 'CDM-23212'
where intakeservreqchildremovalid = 'ba873300-8f80-40e2-982c-18c5033cc82f';