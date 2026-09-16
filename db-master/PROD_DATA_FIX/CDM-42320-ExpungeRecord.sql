/*
Issue: Please do a data fix to expunge the case as requested
Category/Module: Support
Root cause: Case expungement as part of data cleanup
Fix provided: DB query to expunge the case
Data/Code fix ticket#: CDM-42320
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Expungement request
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--expunging case
select vl_sqlcode, vs_err_message from cjams.expungcaserequest('IR'::character varying, 'CW2087352'::character varying, null::date);
