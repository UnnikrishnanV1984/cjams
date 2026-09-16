/*
Issue: CJAMS-68429 Cannot break the link to create adoption record
Category/Module: Break the link
Root cause: Duplicate agreement record is created in the DB and this is not allowing to break the link.
This is a known issue as there is a subsidy agreement record without subsidy rate in DB.
Need data fix to remove the duplicate subsidy agreement from DB so the break the link can be submitted for supervisor approval.
Case number 221030017865 and break the link can be done after removing the duplicate subsidy agreement from DB.
Fix provided:  Data fix is done to delete duplicate subsidy agreement for the case 221030017865
Data/Code fix ticket#: CJAMS-68429
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: BA/QA is trying to replicate this and then we will work on the code fix.
*/

update adoptionagreement 
set activeflag =0, updatedby ='CJAMS-68429', updatedon =now()
where adoptionagreementid ='2799d9ba-aa85-42c8-9254-b2e258c65981' and adoptionplanningid ='d5de914e-ecac-4ae5-b8e1-7c9ee0e73ce0' and activeflag =1;

 update routing 
 set activeflag = 0,
     updatedby = 'CJAMS-68429',
     updatedon = now()
 where routingid = '2dbb405b-d35c-4910-8211-a3f786e5618d' and activeflag =1;