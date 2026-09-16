/*
   Issue Description: CDM-36472
   Category/ Module  : delete intake 
   Root cause: user wants to delete intake
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- The intake is only present in these two tables

update cjams.intakedastatus set activeflag =0,updatedby ='CDM-36472', updatedon =now()
where intakenumber ='I221010297925';

update cjams.intakedastaging set activeflag =0,updatedby ='CDM-36472',updatedon =now()
where intakenumber ='I221010297925' and activeflag=1;
