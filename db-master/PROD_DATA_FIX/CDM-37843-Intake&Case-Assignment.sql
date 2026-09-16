/*
-- CDM-37843 - Intake & Case Assignment Data Fix Needed
-- Category / Module: Intake / Case Assignment
-- Root Cause: 241030292855:This case had a referral completed on 3/12/24. 
               Something incorrectly occurred with the supervisor's case connection as it showed a case number of: 241021921047, which is unsearchable. 
	       There are also incorrect Program assignments related to this occurrence of CPS, which is not valid. 
               These CPS program assignments need to be removed from all the persons in this case. 
	       The worker is not able to program assign the children as of 3/12/24 as she can only assign 3/18/24, which would also need to be changed/data fix. 
	       The worker began the case on 3/12/24 when it was assigned but unfortunately this error was made during the intake approval and case connection. 
	       Intake approval date needs to be updated from 03/18/2024 to 03/12/20242. 
	       Service case start date needs to be updated from 03/18/2024 to 03/12/20243. 
	       Under Decision tab, Requested Date needs to be updated from 03/18/2024 to 03/12/2024.
-- Fix Provided: Datafix has been done.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from servicecasedisposition where servicecasedispositionid = '9070bf70-2931-4cc8-ab47-03c8d094446b';

update servicecasedisposition 
set statusdate = '2024-03-12 12:31:27', effectivedate = '2024-03-12 12:31:27', updatedby = 'CDM-37843', updatedon = now()
where servicecasedispositionid = '9070bf70-2931-4cc8-ab47-03c8d094446b';

select * from servicecase where servicecasenumber = '241030292855';

update servicecase 
set insertedon = '2024-03-12 12:30:27', updatedby = 'CDM-37843', updatedon = now()
where servicecaseid = 'd851118f-0047-4c83-ad22-76414ae6f202';

select * from routing where objectid = 'I241012082586';

update routing 
set insertedon = '2024-03-12 12:00:26', updatedon = '2024-03-12 12:30:26', updatedby = 'CDM-37843'
where routingid = '678d3ffd-a70a-4038-8a8b-1f8acff13934';

select * from caseassignment where caseassignmentid = '3a33eecd-507b-4eec-8305-fd8160d356a2';

update caseassignment 
set startdate = '2024-03-12 12:04:41', updatedon = now(), updatedby = 'CDM-37843'
where caseassignmentid = '3a33eecd-507b-4eec-8305-fd8160d356a2';