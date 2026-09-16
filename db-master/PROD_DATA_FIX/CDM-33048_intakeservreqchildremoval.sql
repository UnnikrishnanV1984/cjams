-- CDM-33048 - removal duplicated itself
/*
-- Issue Description: The system did not duplicate removal and this is not an application issue as the draft removal was created on 07/06/2023 12:04 PM by Sheronda Gross.

-- Category/ Module: Child Removal
-- Root cause:   
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

UPDATE cjams.intakeservreqchildremoval
SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-33048'
WHERE intakeservreqchildremovalid='b55f4408-345c-444b-9d54-f0b2482881ee' and personid='2285a439-4500-46b9-ae75-62de45548a1e';

UPDATE cjams.intakeservreqchildremoval_history
SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-33048'
WHERE intakeservreqchildremovalid='b55f4408-345c-444b-9d54-f0b2482881ee' and activeflag = 1;
