/*
   Issue Description: CJAMS-57972
   Category/ Module  : Prod data fix to connect with correct intakeservreqactor id
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update intakeservreqchildremoval set intakeservicerequestactorid = '097f25fb-d7a2-4914-a1fc-fa49050c1d20', updatedby = 'CJAMS-57972', updatedon = now()
where intakeservreqchildremovalid in ('75af4935-3376-4c48-a1b1-6f4f4e1c74a3','429a0d69-fe17-4819-8376-91b5aaa7e67d','f4ff4665-f1a9-4c68-a044-b266db88f3ed') and intakeservicerequestactorid in ('b7c8a452-1b91-4941-91d3-089b8267384a');

update gapeligibilityinfo set activeflag = 0, updatedby = 'CJAMS-57972', updatedon = now()
where client_id = '4137015' and guardian_subsidy_id = '1005899' and activeflag = 1;