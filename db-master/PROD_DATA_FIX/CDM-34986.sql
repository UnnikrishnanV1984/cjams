/*
 * CDM-34986 - GAP Process
 * Customer Email ID:amanda.young2@maryland.gov
 * Customer Name:Amanda Young
 * Focus Area:Services: Other
 * Description - 221030016439:I am in the process of completing the GAP in CJAMS. I need assistance with the removal date. Is it possible 
 * to have the end date taken off of the removal so the placement can be entered and GAP completed. 
 * remove the child removal end date as requested.
 * CJAMS PID# : 200872836 (Mylo Rodas)
 *
 */

select exitdate, returntransts, * from intakeservreqchildremoval where intakeservreqchildremovalid = 'e446da3a-a481-49ac-be3d-f7ccf10d0db3';
UPDATE cjams.intakeservreqchildremoval
SET exitdate=NULL, returntransts=NULL, updatedby='CDM-34986', updatedon=now() 
WHERE intakeservreqchildremovalid='e446da3a-a481-49ac-be3d-f7ccf10d0db3';

select enddate ,* from personprogramarea where personprogramid = '30df843d-6620-4ecc-91e2-087ba378bed4';
UPDATE cjams.personprogramarea
SET enddate=NULL, updatedby='CDM-34986', updatedon=now() 
WHERE personprogramid='30df843d-6620-4ecc-91e2-087ba378bed4'::uuid; 

select end_dt, * from tb_client_eligibility where case_id = '221030016439';
UPDATE cjams.tb_client_eligibility
SET end_dt=NULL, update_user_id='CDM-34986', update_ts=now() 
WHERE eligibility_id=10005147 and case_id = '221030016439';
