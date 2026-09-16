/*
 * CDM-34877 - Re-Open Removal
 * Customer Email ID:amanda.young2@maryland.gov
 * Customer Name:Amanda Young
 * Focus Area:Placement
 * Description - 221030016439:re-open the removal so the GAP can be completed in CJAMS
 * remove the child removal and OOH program assignment end date.
 * 
*/


select exitdate, returntransts, * from intakeservreqchildremoval where intakeservreqchildremovalid = 'e446da3a-a481-49ac-be3d-f7ccf10d0db3';
UPDATE cjams.intakeservreqchildremoval
SET exitdate=NULL, returntransts=NULL, updatedby='CDM-34877', updatedon=now() 
WHERE intakeservreqchildremovalid='e446da3a-a481-49ac-be3d-f7ccf10d0db3'::uuid;

select enddate ,* from personprogramarea where personprogramid = '30df843d-6620-4ecc-91e2-087ba378bed4';
UPDATE cjams.personprogramarea
SET enddate=NULL, updatedby='CDM-34877', updatedon=now() 
WHERE personprogramid='30df843d-6620-4ecc-91e2-087ba378bed4'::uuid; 

select end_dt, * from tb_client_eligibility where case_id = '221030016439';
UPDATE cjams.tb_client_eligibility
SET end_dt=NULL, update_user_id='CDM-34877', update_ts=now() 
WHERE eligibility_id=10005147 and case_id = '221030016439';
