/*
   Issue Description: CDM-32018
   Category/ Module  : 
   Root cause: user want to delete the intake I231010368466
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update
   intakedastaging
set
   activeflag = 0,
   updatedby = 'CDM-32018',
   updatedon = now()
where
   intakenumber = 'I231010368466'
   and activeflag = 1;


update
   intakedastatus
set
   activeflag = 0,
   updatedby = 'CDM-32018',
   updatedon = now()
where
   intakenumber = 'I231010368466'
   and activeflag = 1;