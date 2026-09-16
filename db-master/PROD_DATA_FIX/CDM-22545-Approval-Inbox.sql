/*
   Issue Description: CDM-22545
   Category/ Module  : Delete the approval records from case pending approval
   Root cause: user wants to delete the records 
   Pull request# for code fix: 6706
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update routing 
set activeflag = 0,
    updatedby = 'CDM-22545',
    updatedon = now()
where routingid = 'd6101efd-52b8-4db4-96c7-3888e28a12f8';


update routing 
set activeflag = 0,
    updatedby = 'CDM-22545',
    updatedon = now()
where routingid = 
'8ca44171-606b-4259-a6b6-5de95b661cdd';