/*
Issue Description: CJAMS-67959
Category/Module: Glitched Referral-Disappeared 
Root cause:There is a junk value which is stored in database for teamtypekey, instead of CW its saved as CW~true due to which the issue has occured, if we modify that value to CW , we are able to search the intake through global search, and the data is available inside the intake,
 requested to remove the intake referrals I261014056744 by user as its no longer needed
Fix provided: Data fix has been promoted to remove the intake referral I261014056744
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/

update intakedastatus 
set activeflag=0,updatedon=now(),updatedby='CJAMS-67959'
where intakenumber ='I261014056744' and activeflag=1;

update intakedastaging 
set activeflag=0,updatedon=now(),updatedby='CJAMS-67959'
where intakenumber ='I261014056744' and activeflag=1;