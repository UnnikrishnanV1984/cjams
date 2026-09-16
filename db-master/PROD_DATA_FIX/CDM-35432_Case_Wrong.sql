/*
 Issue Description: CDM-35432
 Category/ Module  :  Intake
 Root cause: Remove the case connect between the service case 3261490 and the intake I231011411533.Screen-out the intake I231011411533
 Fix: Screened out intake from updating intakesnapshot, intakedstaging and routing tables. Also, disconnected the service case from intake
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 */
-- Screen-out Intake
update
    intakesnapshot
set
    updatedby = 'CDM-35432',
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
    intakenumber = 'I231011411533'
    and activeflag = 1;

update
    intakedastaging
set
    status = 'Closed',
    updatedby = 'CDM-35432',
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
    intakenumber = 'I231011411533'
    and activeflag = 1;

select
    eventcode,
    routingstatustypeid,
    activeflag,
    updatedby,
    updatedon
from
    routing
where
    routingid = '1cec0cf7-9848-4383-9f8b-c2c347e21437'
    and objectid = 'I231011411533';

update
    routing
set
    routingstatustypeid = 8
where
    routingid = '1cec0cf7-9848-4383-9f8b-c2c347e21437'
    and objectid = 'I231011411533';

-- To disconnect I231011411533 and Service Case 3261490
select
    actiontype,
    servicerequestnumber,
    intakeserviceid,
    servicecaseid,
    activeflag,
    updatedby,
    updatedon
from
    intakeservicerequest
where
    intakenumber = 'I231011411533';

update
    intakeservicerequest
set
    servicecaseid = null,
    updatedby = 'CDM-35432',
    updatedon = now()
where
    intakenumber = 'I231011411533';