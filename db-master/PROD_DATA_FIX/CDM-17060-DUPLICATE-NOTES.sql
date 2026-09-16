/*
   Issue Description: CDM-17060
   Category/ Module  : Approval screen
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.progressnote 
	set	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-17060'
	where progressnoteid = '72f9b324-c738-4d59-a0ab-f6d966ec3b5e';