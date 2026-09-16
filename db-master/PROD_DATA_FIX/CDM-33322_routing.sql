/*
   Issue Description: CDM-33322
   Category/ Module  : Perm Plan Review
   Root cause: The Permanency Plan Review has been completed and approved. It has not fallen off my inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-33322'
where routingid in ('5eb502f1-f295-493c-a54f-2fd065143863','b26411b1-9ff1-4c7e-b392-1126421eab9a');
