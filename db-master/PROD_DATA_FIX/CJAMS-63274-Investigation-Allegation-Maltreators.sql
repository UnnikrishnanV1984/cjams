/*
Issue Description: 231021286299:I completed the expungement tab to modify this finding to "Unsubstantiated- Unnamed" but the maltreator's name is still populating.
Root cause: The Appeals Dashboard shows the correct name because it looks at the appeal records directly.But the Investigation Findings page gets the maltreator name from another place in the system — a table that still had the old person linked.
That link wasn’t updated when the finding changed to “Unsubstantiated-Unnamed,” so the old name continued to appear there until it was corrected.
Fix provided: update into investigationallegationmaltreators table
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: data Error.
*/
update investigationallegationmaltreators
set intakeservicerequestactorid = 'afda2d36-4ccb-4f0b-b210-c616a55e0026',updatedby ='CJAMS-63274',updatedon =now()
where investigationallegationmaltreatorsid = 'a24d0c8e-4fd4-4256-a8a5-a7bc6bc78088' and activeflag = 1;