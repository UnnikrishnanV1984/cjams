/*
Issue: Please update the subsidy rate amount from $535 to $585 for the highlighted subsidy rate slab.
Category/Module: Error
Root cause: User has entered the incorrect subsidy rate amount as $535
Fix provided: DB query to change subsidy rate
Data/Code fix ticket#: CDM-42610
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating gapagreementrate
update gapagreementrate
set paymentamout = 585, updatedby = 'CDM-42610', updatedon = now()
where gapagreementrateid = 'c154249b-f2d9-433d-9baf-f245bf506895' and activeflag = 1;

--Updating gapratesrevision
update gapratesrevision
set paymentamt = 585, approvaldate = now(), updatedby = 'CDM-42610', updatedon = now()
where gaprateid = 'c154249b-f2d9-433d-9baf-f245bf506895';