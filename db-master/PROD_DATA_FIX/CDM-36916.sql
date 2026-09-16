/*
 * CDM-36916 - Removal Date Inconsistency
 * Customer Email ID:frank.mcgough1@maryland.gov
 * Description - 3254828:Discrepancy noted in the dates displayed on the removal screen as well as the FC milestone. 
 * Milestone and removal summary screens show removal date of 12/12/23, but the removal detail says 12/13/23. 
 * This is causing issues with health examination timer on the milestone.
 * There is a different start date displayed in the removal history (12/12/2023) and detailed removal (12/13/2023).
 * Client ID# 202069459 (Jolina Avila)

 */

--select 	rm.removalid, rm.intakeservreqchildremovalid, rm.personid , rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
--from 	intakeservreqchildremoval rm 
--where rm.personid = 'a4a521eb-f4ac-4cc8-ab76-fd5ac6ef71af' and rm.activeflag = 1;

--select removaldate, * from intakeservreqchildremoval_history where intakeservreqchildremovalid='df47a3a9-5b0f-42fe-ba8d-5300f19948b8' and activeflag=1;

UPDATE cjams.intakeservreqchildremoval_history
SET rowtype='HISTORY', updatedby='CDM-36916' -- REVISION
WHERE intakeservreqchildremovalhistoryid='ee226e15-f1b7-422f-9099-e4f76559e970';
