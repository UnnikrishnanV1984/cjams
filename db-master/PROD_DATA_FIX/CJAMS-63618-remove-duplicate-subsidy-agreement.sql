/*
Issue: CJAMS-63618 Cannot break the link to create adoption record
       3303517:Subsidy Rate approved by supervisor, not allowing to break the link, saying subsidy rate is not finalized
Category/Module: Break the link
Root cause: Duplicate agreement record is created in the DB and this is not allowing to break the link.
This is a known issue as there is a subsidy agreement record without subsidy rate in DB.
Need data fix to remove the duplicate subsidy agreement from DB so the break the link can be submitted for supervisor approval.
Case number 3303517 and break the link can be done after removing the duplicate subsidy agreement from DB.
Fix provided:  Data fix is done to delete duplicate subsidy agreement for the case 3303517
Data/Code fix ticket#: CJAMS-63618
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: BA/QA is trying to replicate this and then we will work on the code fix.
*/


update adoptionagreement
set activeflag = 0,
    updatedby = 'CJAMS-63618',
    updatedon = now()
 where adoptionagreementid = 'b1d54b2c-89d2-4b1a-a966-cf6bf353e3d9';


 update routing 
 set activeflag = 0,
     updatedby = 'CJAMS-63618',
     updatedon = now()
 where objectid = 'b1d54b2c-89d2-4b1a-a966-cf6bf353e3d9';