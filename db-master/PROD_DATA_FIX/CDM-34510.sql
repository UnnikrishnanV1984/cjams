
/*
   Issue Description: CDM-34510
   Category/ Module  : Intake
   Root cause: User requested to remove Intake 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34510'
where intakenumber in ('I231010513755') 
	and activeflag = 1 ;
	

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34510'
where intakenumber in ('I231010513755') 
	and activeflag = 1 ;
	
 update intakesnapshot
   set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34510'
where intakenumber in ('I231010513755') 
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34510'
where objectid in ('I231010513755') 
	and activeflag = 1 ;