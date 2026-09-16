/*
 * CDM-39364 - Duplicate case 
 * Customer Email ID:monique.mackell2@maryland.gov
 * Description - Dashboard:Hello,I'm seeing a duplicate case on my dashboard for case #241022264482 
 * remove one of the duplicate family assignment.
 * 
 */

UPDATE cjams.caseassignment
SET activeflag=0, updatedby='CDM-39364', updatedon=now() 
WHERE caseassignmentid='2fd4fb76-f05f-4f84-9662-43154fdf022b';
