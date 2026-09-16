/*
   Issue Description: CJAMS-59841
   Category/ Module  :  remove intake
   Root cause: User Error, started new intake and user asked to remove intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastaging 
set activeflag = 0, 
	updatedby = 'CJAMS-59954', 
	updatedon = now()
where intakenumber = 'I251013248109';

update intakedastatus 
set 
	activeflag = 0,
	updatedby = 'CJAMS-59954',
	updatedon = now()
where intakenumber = 'I251013248109';
