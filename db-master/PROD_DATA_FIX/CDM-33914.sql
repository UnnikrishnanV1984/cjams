/*
 * CDM-33914 - Child was never removed
 * Customer Email ID:rhonda.gardner@maryland.gov
 * Customer Name:Rhonda Gardner
 * Focus Area:Child Removal
 * Description - 3299948:Please remove the Removal for Xavier Clark; he was not removed. The removal was initiated for Xaiver, 
 * but it was his brother that was removed. 
 * Verified in Prod and there is a draft removal has been created. Please remove the draft removal as requested.
 * 
 * */

select activeflag, * from intakeservreqchildremoval where intakeservreqchildremovalid = '71a655e6-681f-48a3-9be5-8906175ae11a';

UPDATE cjams.intakeservreqchildremoval
SET activeflag=0, updatedby='CDM-33914', updatedon=now() 
WHERE intakeservreqchildremovalid='71a655e6-681f-48a3-9be5-8906175ae11a'::uuid;
