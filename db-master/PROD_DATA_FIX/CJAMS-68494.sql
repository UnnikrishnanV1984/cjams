/*
Issue Description: UNABLE TO SUBMIT SUBSIDY 
Category/Module: Bug
Root cause: There is an agreement start date missing in database, Data fix is needed to add the agreement start date.
Fix provided:Data fix is done to update the  agreement start date as requested
Data/Code fix ticket#: CJAMS-68494
Regression Impacts: N/A
Is Code fix Required?: No- Not replicable 
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update gapagreement set startdate = '2012-08-03 05:00:00.000',
 updatedon = now(), updatedby = 'CJAMS-68494'
 where gapagreementid = '127ca8ac-b82f-461f-9c12-79685396964e';


update gapagreementrevision set startdate = '2012-08-03 05:00:00.000',
updatedon = now(), updatedby = 'CJAMS-68494'
where gapagreementid = '127ca8ac-b82f-461f-9c12-79685396964e';