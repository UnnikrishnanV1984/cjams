  /*
 Issue Description:CDM-18432
 Category/ Module:cps investigation
 Root cause: removed user
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update intakeservicerequestactor set activeflag='0',updatedby='CDM-18432',updatedon=now()where personid = '9a8c46ec-fcc9-449a-8a3d-63ff0a773e8d' and intakeserviceid ='7dea8f42-d094-43e7-86f1-a17ccbf4d58d';