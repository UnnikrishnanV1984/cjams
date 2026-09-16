/*
   Issue Description: CDM-32070
   Category/ Module  : 
   Root cause: user want to remove the intake I221010297808
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update
   intakedastaging
set
   activeflag = 0,
   updatedby = 'CDM-32070',
   updatedon = now()
where
   intakenumber = 'I221010297808'
   and activeflag = 1;


update
   intakedastatus
set
   activeflag = 0,
   updatedby = 'CDM-32070',
   updatedon = now()
where
   intakenumber = 'I221010297808'
   and activeflag = 1;