/*
 * CDM-33979 - Removal End Date
 * Customer Email ID:erika.robinson@maryland.gov
 * Customer Name:Erika Robinson
 * Focus Area:Child Removal
 * Description - Dashboard:Good Morning,Can you please reopen the removal for this child, Traquaun I Fields #2627331. A placement needs to be put in out of sequence.
 * Remove the Child Removal & OOH Program assignment end date
 * 
 */

select exitdate, * from intakeservreqchildremoval where intakeservreqchildremovalid = 'b9692f4c-e48f-4520-b2b4-8dd4cbb26205';
UPDATE cjams.intakeservreqchildremoval
SET exitdate=NULL, updatedby='CDM-33979', updatedon=now() 
WHERE intakeservreqchildremovalid='b9692f4c-e48f-4520-b2b4-8dd4cbb26205';

select enddate, * from personprogramarea where personprogramid = '94515340-628d-4463-a58e-ccb66fad8f92';
UPDATE cjams.personprogramarea
SET enddate=NULL, updatedby='CDM-33979', updatedon=now() 
WHERE personprogramid = '94515340-628d-4463-a58e-ccb66fad8f92';
