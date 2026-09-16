/*
   Issue Description: CJAMS-66954
   Category/ Module: Assignments
   Root Cause: Case looks closed but it is open on workload under worker Amy Smith. There is a active assignment which needs to be end dated  
   Fix provided: End dated the active assignment as requested by user
*/

update caseassignment 
set enddate ='2023-08-22 00:00:00.000', updatedby ='CJAMS-66954', updatedon =now()
where caseassignmentid ='9c629788-9230-48d0-8bc3-0c5077da2196' and activeflag =1;