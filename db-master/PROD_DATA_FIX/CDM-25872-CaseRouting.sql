/*
   Issue Description: CDM-25872
   Category/ Module  : case pending inbox
   Root cause: user wants to remove records of other county which are not assigned to
   Pull request# for code fix: 6603
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-25872' 
where routingid in ('5ee5c22e-068b-40d4-bcf0-9b48744f57fc', '946bbc06-4941-4f12-a317-09d0951d4826');
