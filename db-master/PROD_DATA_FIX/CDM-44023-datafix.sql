/*
Issue Description: Please do a data fix to update the subsidy rate amount to  $903.67 instead of $29.71 
Category/Module: Error
Root cause: Wrong gap agreement amount was entered
Fix provided: DB queries to change gap agreement amount
Data/Code fix ticket#:CDM-44023
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


--Updating payment amount in gapagreementrate
update gapagreementrate
set paymentamout = 903.67, updatedby = 'CDM-44023', updatedon = now()
where gapagreementrateid = '770c8136-0d92-499a-bee3-cfea04fa475b' and activeflag = 1;

--Updating payment amount in gapratesrevision
update gapratesrevision
set paymentamt = 903.67, approvaldate = now(), updatedby = 'CDM-44023', updatedon = now()
where gaprateid = '770c8136-0d92-499a-bee3-cfea04fa475b';
