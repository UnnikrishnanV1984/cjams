/*
Issue Description: wrong start date of GAP
Category/Module: Bug
Root cause: Not a defect ,User entered incorrect   agreement start date  and requested for data fix.
Fix provided:Data fix is done to update the  agreement start date as requested
Data/Code fix ticket#: CJAMS-68645
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update gapagreement set startdate = '2026-06-03 05:00:00.000',
 updatedon = now(), updatedby = 'CJAMS-68645'
 where gapagreementid = '86981f96-c317-42b9-8541-eb24ef2a5159';


update gapagreementrevision set startdate = '2026-06-03 05:00:00.000',
updatedon = now(), updatedby = 'CJAMS-68645'
where gapagreementid = '86981f96-c317-42b9-8541-eb24ef2a5159';