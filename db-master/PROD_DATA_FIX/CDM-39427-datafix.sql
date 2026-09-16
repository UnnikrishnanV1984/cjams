/*
  Issue Description:  CDM-39427
   Category/ Module  : Approval 
   Root cause: Case screened in but was not able to case connect it 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


-- Delete Intake Number: I241012495001

	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39427'
where objectid ='I241012495001' 
	and activeflag = 1 ;


update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39427'
where intakenumber ='I241012495001'
	and activeflag = 1 ;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39427'
where intakenumber ='I241012495001'
	and activeflag = 1 ;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39427'
where intakenumber ='I241012495001'
	and activeflag = 1 ;