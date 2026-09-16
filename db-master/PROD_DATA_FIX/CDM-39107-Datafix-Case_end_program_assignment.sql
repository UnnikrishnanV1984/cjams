/* 
    Issue Description: CDM-39107
   Category/ Module  : SDM
   Root cause: Data fix need to change and update end time.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
    
*/

/* To update the end date from 05/19/2024 to 05/20/2024 */

update caseassignment 
set enddate='2024-05-20',updatedby='CDM-39107',updatedon='now()'
where caseassignmentid='93a7913b-5d32-43de-8f15-e7e0227e7b29';

/* To update the end date to 05/20/2024 */

update caseassignment 
set enddate='2024-05-20',updatedby='CDM-39107',updatedon='now()'
where caseassignmentid='1ace3f70-8d34-452b-91cf-20f22f587a82';

/* To update the end date for program assignment to a person */

update personprogramarea
set enddate='2024-05-20',updatedby='CDM-39107',updatedon='now()'
where personid='f6a8bd0f-56aa-4db4-aeee-7949213dc8be';