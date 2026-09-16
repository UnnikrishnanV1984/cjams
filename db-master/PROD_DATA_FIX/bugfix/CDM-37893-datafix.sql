/*
   Issue Description: CDM-37893
   Category/ Module  : Delete report
   Root cause: I241012087914:Duplicate report. Please Delete
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37893'
where intakenumber in ('I241012087914') 
    and activeflag = 1 ;
    

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37893'
where intakenumber in ('I241012087914') 
    and activeflag = 1 ;
    
 update intakesnapshot
   set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37893'
where intakenumber in ('I241012087914') 
    and activeflag = 1 ;
    
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37893'
where objectid in ('I241012087914') 
    and activeflag = 1 ;