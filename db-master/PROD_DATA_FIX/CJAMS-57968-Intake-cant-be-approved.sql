
/*
Issue Description: Override completed, info added but unable to reflect screen out on supervisor decision but shows screened out in the submission history
Category/Module: Intake
Root cause: user can not screenout the case because of screenout info missing in db.
Fix provided: DB queries to screen the intake out from relevant tables.
Data/Code fix ticket#: CJAMS-57968
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: glitch
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

UPDATE
    intakedastaging
SET
    updatedby = 'CJAMS-57968',
    updatedon = now(),
    jsondata = jsonb_set(
        jsondata,
        '{DAType}',
        jsonb_set(
            jsondata -> 'DAType',
            '{DATypeDetail}',
            jsonb_set(
                jsondata -> 'DAType' -> 'DATypeDetail',
                '{0}',
                jsonb_set(
                    jsondata -> 'DAType' -> 'DATypeDetail' -> 0,
                    '{supDisposition}',
                    '"ScreenOUT"'
                )
            )
        )
    )
WHERE
    intakenumber = 'I251013231682'
    AND activeflag = 1;

UPDATE
    intakedastaging
SET
    updatedby = 'CJAMS-57968',
    updatedon = now(),
    jsondata = jsonb_set(
        jsondata,
        '{disposition,0,supDisposition}',
        '"ScreenOUT"',
        false
    )
WHERE
    intakenumber = 'I251013231682'
    AND activeflag = 1;