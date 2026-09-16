/*
   Issue Description: CJAMS-61050
   Category/ Module: remove intake
   Root cause: user asked to remove intake and do a data fix.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-61050'
where intakenumber = 'I251013314198';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-61050'
where intakenumber = 'I251013314198'
	and activeflag=1;