/*
Issue: CJAMS-62917 Cannot break the link to create adoption record
Category/Module: Break the link
Root cause: Duplicate agreement record is created in the DB and this is not allowing to break the link.
This is a known issue as there is a subsidy agreement record without subsidy rate in DB.
Need data fix to remove the duplicate subsidy agreement from DB so the break the link can be submitted for supervisor approval.
Case number 3229725 and break the link can be done after removing the duplicate subsidy agreement from DB.
Fix provided:  Data fix is done to delete duplicate subsidy agreement for the case 3229725
Data/Code fix ticket#: CJAMS-62917
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: BA/QA is trying to replicate this and then we will work on the code fix.
*/


update adoptionagreement
set activeflag = 0,
    updatedby = 'CJAMS-62917',
    updatedon = now()
 where adoptionagreementid = 'c4094195-1fc0-4d1c-8b46-e454aafc7b93';


 update routing 
 set activeflag = 0,
     updatedby = 'CJAMS-62917',
     updatedon = now()
 where objectid = 'c4094195-1fc0-4d1c-8b46-e454aafc7b93';


