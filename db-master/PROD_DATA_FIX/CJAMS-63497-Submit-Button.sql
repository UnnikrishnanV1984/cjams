
/*
Issue Description: I251013429921:The Submit For Approval button is not available on this case. I have refreshed the page and logged out/in and it is not showing up in this referral.
Root cause: Jurisdiction remained incorrect because the intake record was not synchronized with the updated county assignment after the Transfer approval.
Fix provided: DB queries  update intakesnapshot,intakedastaging, tables
Data/Code fix ticket#: CJAMS-63497
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: data Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


UPDATE intakedastaging
SET jsondata = jsonb_set(
        jsondata,
        '{General,countyid}',
        to_jsonb('58bac299-69ce-4cd2-8e9c-2773524050db'::text)
    ),
    updatedby = 'CJAMS-63497',
    updatedon = now()
WHERE intakenumber = 'I251013429921'
  AND activeflag = 1;

 
UPDATE intakedastatus
SET jsondata = jsonb_set(
        jsondata,
        '{General,countyid}',
        to_jsonb('58bac299-69ce-4cd2-8e9c-2773524050db'::text)
    ),
    updatedby = 'CJAMS-63497',
    updatedon = now()
WHERE intakenumber = 'I251013429921'
  AND activeflag = 1;

