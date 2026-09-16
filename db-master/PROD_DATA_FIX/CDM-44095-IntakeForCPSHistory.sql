/*
Issue Description: Please provide a data fix since this is not reproducible in stg3 and the referral (I251013217793) should show closed at intake and it should show in the workers closed intakes.
Category/Module: Support
Root cause: Data error casused intake not yet appears to cloased.
Fix provided: DB queries to intake closed it in intakeservicerequest,intakedastaging,intakedastatus tables.
Data/Code fix ticket#: CDM-44095
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--Updating intakeservicerequest
update intakeservicerequest
set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', activeflag = 1, updatedby = 'CDM-44095', updatedon = now()
where intakeserviceid = '9eec4cac-de7d-4813-9af4-0a0f5b75a155';

--Updating intakedastaging
update intakedastaging
set status = 'Closed', updatedby = 'CDM-44095', updatedon = now()
where intakenumber = 'I251013217793' and activeflag = 1;

--Updating intakedastatus
update intakedastatus
set status = 8, updatedby = 'CDM-44095', updatedon = now()
where intakedastatusid = '986d150e-c5c8-4376-8bed-8bb9214a0b0a' and activeflag = 1;