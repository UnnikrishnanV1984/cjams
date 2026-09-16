/*
 * CDM-34156 - Duplicate child removal in draft
 * Customer Email ID:morris.richmond@maryland.gov
 * Customer Name:Morris Richmond
 * Focus Area:Child Removal
 * Description - 3142427:I have completed the child removal for the case of Kyia Nutter, #201683315. I accidentally started a draft as well that remains open. 
 * delete the draft
 */
 
select activeflag , * from intakeservreqchildremoval where intakeservreqchildremovalid = 'cae4e5dd-ceed-416e-a4e2-e27f74ae7769';
UPDATE cjams.intakeservreqchildremoval
SET activeflag=0, updatedby='CDM-34156', updatedon=now() 
WHERE intakeservreqchildremovalid='cae4e5dd-ceed-416e-a4e2-e27f74ae7769'::uuid;

select activeflag , * from intakeservreqchildremoval_history where intakeservreqchildremovalid = 'cae4e5dd-ceed-416e-a4e2-e27f74ae7769';
UPDATE cjams.intakeservreqchildremoval_history
SET activeflag=0, updatedby='CDM-34156', updatedon=now() 
WHERE intakeservreqchildremovalid='cae4e5dd-ceed-416e-a4e2-e27f74ae7769'::uuid;