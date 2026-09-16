/*
 * CDM-33760 - Imani Williams
 * Customer Email ID:jeannette.mcneil@maryland.gov
 * Customer Name:Jeannette McNeill
 * Focus Area:Child Removal
 * Description - 3205351:We are trying to close this case and it looks like there are two child removals. One has been end dated and the other is in draft. 
 * We cannot figure out how to end the child removal that is still in draft so we can close the case.
 *  
 */

select activeflag, * from intakeservreqchildremoval where intakeservreqchildremovalid = '00883bb4-91af-4e7d-b01f-2cb9dd17ce42';
UPDATE cjams.intakeservreqchildremoval
SET activeflag=0, updatedby='CDM-33760', updatedon=now() 
WHERE intakeservreqchildremovalid='00883bb4-91af-4e7d-b01f-2cb9dd17ce42'; 