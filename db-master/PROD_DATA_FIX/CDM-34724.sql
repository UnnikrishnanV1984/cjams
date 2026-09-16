/*
 * CDM-34724 - Stuck Case
 * Customer Email ID:tracey.bosick@maryland.gov
 * Customer Name:Tracey Bosick
 * Focus Area:Decision
 * Description - Dashboard:I closed the Beidenback case on 8/23 but it is still appearing on the worker's tree when I pull her cases. 
 * I can see it on mine, but she can not see it on her. The decision tab shows that I approved to close it on 8/23/23. Under Assignments, 
 * it shows the family rights are still open? This is an error.
 * data fix to end date the Family assignment on 08/23/2023.
 * 
 */

select startdate , enddate , * from caseassignment where caseassignmentid = 'a23794dc-3829-40a9-bca5-7a62566903e2';

UPDATE cjams.caseassignment
SET enddate='2023-08-23', updatedby = 'CDM-34724', updatedon = now() 
WHERE caseassignmentid='a23794dc-3829-40a9-bca5-7a62566903e2'::uuid; 
