/*
-- Issue Description: 
	CDM-29666 :Child Removal Ive
	 Category/ Module: Ive Adoption case
-- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/
UPDATE cjams.intakeservreqchildremoval
SET intakeservicerequestactorid='5b8fed79-78f5-4f91-b0d7-7e4f510cc3ca', updatedby='CDM-29666', updatedon=now()
WHERE intakeservreqchildremovalid = '7c1122d2-6771-41ac-89b7-73f73c4a55e3' and removalid=196645;

UPDATE cjams.adoptioninitialeligibilityinfo
SET ivestatus='APPROVED', updatedby='CDM-29666', updatedon=now()
WHERE adoptioninitialid='3064ceda-78ab-446e-8899-bb6357ca2f52' and clientid=201015691;

