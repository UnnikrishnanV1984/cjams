/*
   Issue Description: CDM-30169
   Category/ Module  : Approval inbox 
   Root cause: user wants to delete the record which got in error 
   Pull request# for code fix: 8611
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing
set activeflag = 0, updatedby = 'CDM-30169',
updatedon = now()
where routingid = 'd656b0ec-7a2d-4539-b122-12e2b4e865dd';