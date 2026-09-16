/*
Issue: CJAMS-63927 Subsidy Rate Needs to be entered again.
      3278408:3278408:Need Subsidy Rate to be Cleared to Re-enter because I think the exit was approved before the rate and causing a issue on the break the link page indicating to put rate back in
Category/Module: Break the link
Root cause: Duplicate agreement record is created in the DB and this is not allowing to break the link.
This is a known issue as there is a subsidy agreement record without subsidy rate in DB.
Need data fix to remove the duplicate subsidy agreement from DB so the break the link can be submitted for supervisor approval.
Case ID: 3278408
Client ID: 4485427 (Bella Brooks)
Provider ID: 6003391 (Crystal Sharp)
Placement Structure: Pre-Finalized Adoptive Home
Placement Exit Date: 11/22/2025
Adoption Agreement Start Date: 11/22/2025
Removal Exit Date: 11/22/2025
Fix provided:  Data fix is done to delete duplicate subsidy agreement for the case 3278408
Data/Code fix ticket#: CJAMS-63927
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: BA/QA is trying to replicate this and then we will work on the code fix.
*/


update adoptionagreement
set activeflag = 0,
    updatedby = 'CJAMS-63927',
    updatedon = now()
 where adoptionagreementid = 'e182cc2c-68bf-4df0-af83-a0fa0095f6cf';


 update routing 
 set activeflag = 0,
     updatedby = 'CJAMS-63927',
     updatedon = now()
 where objectid = 'e182cc2c-68bf-4df0-af83-a0fa0095f6cf';