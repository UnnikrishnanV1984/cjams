/*
  Issue Description:  CDM-39879
   Category/ Module  :  Application
   Root cause: user requested to delete pending intake 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39879'
where intakenumber in ('I241012564245') 
	and activeflag = 1 ;

	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39879'
where intakenumber in ('I241012564245') 
	and activeflag = 1 ;
