/*
Issue:Cleaning up tree - need to get rid of referrals:1) I251013224904 - "duplicate referral; I251013224903 entered and screened on 2/12/25"2) I241013174602 - "duplicate referral; I241013174686 entered and screened on 11/12/24"
Root Cause:Intake ('I251013224904','I241013174602') User request to delete intake.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and inserted a record into routing table..
Data/Code fix ticket#: CJAMS-60521
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue was casused by incorrect data stastus, not a problem in the apllication code, so only a data update was needed to correct it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/




update intakedastatus 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-60521'
where intakenumber in ('I251013224904','I241013174602') and activeflag =1;

update intakedastaging 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-60521'
where intakenumber in ('I251013224904','I241013174602')  and activeflag =1;