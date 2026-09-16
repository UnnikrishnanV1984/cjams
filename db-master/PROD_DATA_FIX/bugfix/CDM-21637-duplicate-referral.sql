-- CDM-21637-duplicate-referral
/*
-- Issue Description: 
	1.Duplicate referal is populated in the approval screen
-- Root cause: 
---Fix : This case is withh active falg as 0 so that it doesnt show up in supervisor's queue

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update CJAMS.intakedastaging set
activeflag = 0,updatedby = 'CDM-21637',
updatedon=now()
where  intakenumber ='I221010239128' and activeflag = 1;

update CJAMS.intakedastatus set
activeflag = 0,updatedby = 'CDM-21637',
updatedon=now()
where  intakenumber ='I221010239128' and activeflag = 1;