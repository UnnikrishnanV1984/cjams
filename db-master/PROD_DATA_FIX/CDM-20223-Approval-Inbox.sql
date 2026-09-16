/* 
    Issue Description: CDM-20223
   Category/ Module  : approval inbox
   Root cause: user wants to delete approved records which shows pending
   Pull request# for code fix: 6711
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update routing 
set activeflag = 0,
    updatedby = 'CDM-20223',
    updatedon = now()
where routingid = '0f4125ef-6673-4b8e-8081-7138002be5a2';
