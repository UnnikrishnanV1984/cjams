/* 
    Issue Description: CDM-38641
  Category/ Module  : 
  Root cause: Data Fix to Update the Case (241022000935) start date as 04/26/2024 -9:35 AM
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/


update intakeservicerequest 
set reporteddate = '2024-04-26 09:35:00',
updatedby = 'CDM-38641',
updatedon = now()
where intakeserviceid = '9e0e8af1-4e62-4fd2-8264-2466f37e10f4';
