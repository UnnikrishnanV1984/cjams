/*
  Issue Description: CJAMS-63181 Intake referral locked
  Category/ Module : Intake Dashboard
  Root cause: Data error and intake county ID  did not properly update this cross-county referral.
              We are unable to replicate this issue in stage-3  
  Fix Provided: Data fix has been done to update the countyid to fredrick in Intake so that user can edit the intake.
  Regression Impacts: N/A
  Is Code fix needed: N/A
  Code fix ticket # : N/A
  Reason why no related code fix: Issue is not replicable in stage-3 and we will monitor it for future issues
*/

--Updating intakedastaging
update intakedastaging
set jsondata = jsonb_set(jsondata, '{General, countyid}', '"d0a6f218-4dee-45c3-b842-be7446a5ef41"', false),
updatedby = 'CJAMS-63181', updatedon = now()
where intakenumber = 'I251013390316' and activeflag = 1;

--Updating intakedastatus
update intakedastatus
set jsondata = jsonb_set(jsondata, '{General, countyid}', '"d0a6f218-4dee-45c3-b842-be7446a5ef41"', false),
updatedby = 'CJAMS-63181', updatedon = now()
where intakenumber = 'I251013390316' and activeflag = 1;