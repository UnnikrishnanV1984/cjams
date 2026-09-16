/*
  Issue Description: CDM-39458 Unable to add new rate
  Category/ Module : GAP Subsidy rate
  Root cause: Unable to add new rate as case 3223223:The subsidy rate is under review for 5/1/20234/30/2024 and not showing in supervisor Dashboard
  Fix Provided: Data fix has been provided to show the review record in supervisor approval inbox service case - 3223223
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update routing 
set activeflag = 1, 
    updatedby = 'CDM-39685', 
    updatedon = now() 
    where routingid = 'a9b34587-eb73-4372-9de7-54f1ac989f8b';