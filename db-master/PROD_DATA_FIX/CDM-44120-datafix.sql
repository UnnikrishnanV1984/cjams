/*
   Issue Description: CDM-44120
   Category/ Module  : 
   Root cause: End the case assignment for (Monica Kiefer) 
   user want to remove intake from pending dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/ 


update caseassignment
set enddate = '2025-01-30 08:02:54',
updatedby='CDM-44120', updatedon=now()
where caseassignmentid = 'ead7f3ea-0fe4-4d53-b635-cd9622edf13c'
and activeflag = 1;

update caseassignment
set enddate = '2025-01-17 19:04:47',
updatedby='CDM-44120', updatedon=now()
where caseassignmentid = '2122a3f7-3ef1-4004-a72f-ecbd08a0f2e7'
and activeflag = 1;

UPDATE cjams.intakedastatus
SET status=2, updatedby='CDM-44120', updatedon=now()
WHERE intakenumber='I241013089058';

UPDATE cjams.intakedastaging
SET status='Complete', updatedby='CDM-44120', updatedon=now()
WHERE intakenumber='I241013089058' and activeflag = 1;