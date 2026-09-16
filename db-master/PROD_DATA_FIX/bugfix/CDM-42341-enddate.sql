/*
 * CDM-42341 - End dated a case as requested by user
 * Customer Email ID: michelle.delovich@maryland.gov
 * Description - Assignments -  Assignment should be closed for admin support worker
 * end dated the Admin responsibility with the case close date (10/03/2024) as requested.
 * 
 */

-- select enddate,startdate,* from caseassignment c  where  caseassignmentid ='7ead229c-5d61-4bf4-8093-47f2158213a2';

update caseassignment 
set enddate='2024-10-03 10:44:28.000', updatedby ='CDM-42341', updatedon=now()
where caseassignmentid ='7ead229c-5d61-4bf4-8093-47f2158213a2';