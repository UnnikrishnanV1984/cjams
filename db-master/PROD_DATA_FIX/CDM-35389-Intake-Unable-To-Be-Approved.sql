-- CDM-35389 - Intake unable to be approved
/*
 -- Issue Description: Intake was overrode and now unable to be approved, the screening approval drop down box does not work.
 -- Category/ Module: homedashboard
 -- Root cause: Error while entering data.
 -- Fix Provided: Datafix has been added by updating the intakesnapshot, intakedastaging and rotuing tables.
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 */


UPDATE
    intakesnapshot
SET
    updatedby = 'CDM-35389',
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
where
    intakenumber = 'I231011396190'
    and intakeserviceid = '84912e22-b71c-4799-8863-5701ef3b6cd1';

UPDATE
    intakedastaging
SET
    updatedby = 'CDM-35389',
    updatedon = now(),
    status = 'Closed',
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
    intakenumber = 'I231011396190'
    AND activeflag = 1;

UPDATE
    cjams.routing
SET
    routingstatustypeid = 8,
    updatedby = 'CDM-35389',
    updatedon = now()
WHERE
    routingid = '826b7c60-18e5-477e-806a-df887a1b4170'
    and objectid = 'I231011396190';