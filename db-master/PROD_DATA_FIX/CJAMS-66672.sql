/*
Root Cause: User requested to delete the OOH program assignment as the Child Removal record.
Fix Provided: Fix provided by deleting the OOH program.
Code Fix: NO
*/

update personprogramarea 
set activeflag =0, updatedby ='CJAMS-66672', updatedon =now()
where personprogramid ='046af3a9-712d-4466-87b1-ad83536638ad' and activeflag =1;