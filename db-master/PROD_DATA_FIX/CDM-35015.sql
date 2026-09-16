/*
 * CDM-35015 - CPS
 * Customer Email ID:dawn.blades@maryland.gov
 * Customer Name:Dawn Blades
 * Focus Area:Decision
 * Description - Dashboard:Case closed on 10/20/23 but the case is still showing on supervisors view of the workers caseload
 * Case is completed but still showing as open in supervisors workload.
 * Also worker assignment is not end dated. Please end date the worker assignment with 10/20/2023 and make sure 
 * case is in closed status and closed date is populated in the workload.
 * The worker is Lauren Evans and the case number 231020914530.

*/

update caseassignment
set enddate = '2023-10-20 00:00:00', updatedon = now(), updatedby = 'CDM-35015' 
where caseassignmentid = '2eca9911-413b-46a6-a0f6-eecf93a682c3';
