/*
 * CDM-42154 - End dated a case as requested by user
 * Customer Email ID:pam.elliott@maryland.gov
 * Description - Assignments -  Assignment should be closed for family support worker
 * end dated the Admin responsibility with the case close date (10/03/2024) as requested.
 * 
 */

update caseassignment 
set enddate = '10/03/2024', updatedon = now(),
updatedby = 'CDM-42154'
where caseassignmentid = '5dd39db8-282c-4be4-b363-4a65d371f8d7';