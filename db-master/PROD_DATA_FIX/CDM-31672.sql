
/*
   Issue Description: CDM-31672
   Category/ Module  : 
   Root cause:user want to update Case worker name  Georgina Acquaah-Harrison
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
update routing set fromsecurityusersid='bddc09a2-5ae0-4d5c-aeec-6de1d72f0340',updatedby='CDM-31672',updatedon=now() where objectid='6d19234d-4b2a-4091-a6c6-3a850fcfe1c6';

UPDATE cjams.assessment
SET updatedon=now(),
 updatedby ='bddc09a2-5ae0-4d5c-aeec-6de1d72f0340'
where assessmentid ='6d19234d-4b2a-4091-a6c6-3a850fcfe1c6';