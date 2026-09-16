/*
   Issue Description: CDM-32799
   Category/ Module  : Prod data fix to remove the Person program area for a dummy case
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update personprogramarea set activeflag = 0, updatedby = 'CDM-32799', updatedon = now()
where objectid = 'b8d8d484-1c96-4775-9866-ad4d35ff6eab' and activeflag = 1;