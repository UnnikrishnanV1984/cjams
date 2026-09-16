/*
   Issue Description: CDM-31856
   Category/ Module  : 
   Root cause: user want to update data dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 

update intakesnapshot set jsondata=jsonb_set(jsondata,'{General,countyid}','"817e0751-1fa8-4c31-8233-8fffd6426235"') where intakenumber='I231010495718' and activeflag=1; 

update intaketransfers set approvedby='abe58d96-d2ec-40b3-b2f1-981baab01af9',receivingcountyworker='49ae215c-497c-4ce5-88a6-7b5c087001e7',updatedby='CDM-31856',updatedon=now()
where intaketransferid='3c69a09d-1bb4-4be8-9454-2dbb5a8bfd5b';
