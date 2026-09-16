/*
   Issue Description: CDM-34574
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
    updatedby = 'CDM-34574'
where intakenumber in ('I231010714617') 
	and activeflag = 1 ;
	

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34574'
where intakenumber in ('I231010714617') 
	and activeflag = 1 ;

-- select * from intakesnapshot where intakenumber in ('I231010714617');
-- select * from routing where objectid in ('I231010714617');