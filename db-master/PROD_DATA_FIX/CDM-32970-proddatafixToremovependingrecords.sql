/*
   Issue Description: CDM-32970
   Category/ Module  : Prod data fix to remove pending records
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update routing set activeflag = 0, updatedby = 'CDM-32970', updatedon = now()
where routingid in ('955f6c62-5bbe-4d3f-90b9-901adc254b4b',
'c49d212a-fccd-4e8b-a0c4-355a814b0635',
'073297b1-1ce4-44e6-94e1-d20064790115');