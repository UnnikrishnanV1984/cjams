-- CDM-35100 - case listed wrong
/*
 -- Issue Description: In this case, Supervisor need to screenout the intake.
 
 -- Category/ Module: homedashboard
 -- Root cause: Not yet found.
 -- Fix Provided: Datafix has been added by updating supervisor disposition in intakesnapshot, intakestaging and intakestatus tables .
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 */
UPDATE
    intakesnapshot
SET
    updatedby = 'CDM-35100',
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
    intakenumber = 'I231011391662'
    AND activeflag = 1;

UPDATE
    intakedastaging
SET
    status = 'Closed',
    updatedby = 'CDM-35100',
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
    intakenumber = 'I231011391662'
    AND activeflag = 1;

update
    intakedastatus
set
    status = 8,
    updatedby = 'CDM-35100',
    updatedon = now()
where
    intakenumber = 'I231011391662'
    and activeflag = 1;

update
    routing
set
    routingstatustypeid = 8,
    activeflag=0,
    updatedby = 'CDM-35100',
    updatedon = now()
where
    routingid = '4d2f65ff-ce0c-4543-9eef-82be06b5f92f';