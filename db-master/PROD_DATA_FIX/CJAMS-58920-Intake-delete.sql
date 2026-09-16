/*
   Issue Description: CJAMS-58920
   Category/ Module  :  Referral
   Root cause: user asked to remove intake as it was created for troubleshooting 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58920'
where intakenumber ='I251013260455'
	and activeflag = 1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58920'
where intakenumber = 'I251013260455'
	and activeflag =1;