/*
  Issue Description:CDM-41131
Category/ Module:Application
Root cause: User requested to delete the intake.
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/

-- Delete Intake Number: I241013060951
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-41131'
where objectid in ('I241013060951') 
	and activeflag = 1 ;


update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-41131'
where intakenumber in ('I241013060951') 
	and activeflag = 1 ;

	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-41131'
where intakenumber in ('I241013060951') 
	and activeflag = 1 ;


update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-41131'
where intakenumber in ('I241013060951') 
	and activeflag = 1 ;
