/*
Issue Description: Please do a data fix to update the subsidy rate amount from $835 to $712 as screenshot below.
Category/Module: Error
Root cause: Wrong gap agreement amount was entered
Fix provided: DB queries to change gap agreement amount
Data/Code fix ticket#:CDM-41486
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating payment amount in gapagreementrate
update gapagreementrate
set paymentamout = 712, updatedby = 'CDM-41486', updatedon = now()
where gapagreementrateid = '8677156a-74b1-485d-a521-58d00983a0e3' and activeflag = 1;

--Updating payment amount in gapratesrevision
update gapratesrevision
set paymentamt = 712, approvaldate = now(), updatedby = 'CDM-41486', updatedon = now()
where gaprateid = '8677156a-74b1-485d-a521-58d00983a0e3';