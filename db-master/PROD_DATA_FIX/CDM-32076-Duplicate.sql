/*
   Issue Description: CDM-32076
   Category/ Module  :  person
   Root cause: user wants to rename the existing person and put  it other tab 
    Fix Provided: Did data fix to move person in other tab and change middle name as per the user suggestion 
*/


update cjams.actor set ishouseholdmember =2, updatedby ='CDM-32076', updatedon = now()
where actorid ='686bc3c7-83d8-47db-b983-2316bd37fc42';

update cjams.person set middlename ='Duplicate', updatedby ='CDM-32076', updatedon = now()
where personid ='bd01aea8-c5ef-4a0a-a6e0-384e05cdbb45' and cjamspid ='201175425';