/*
   Issue Description: CDM-43622
   Category/ Module  : Child Welfare
   Root cause: Delete this CPS IR case and screen Out the Intake.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/ 

-- screening out the intake
/*
select * from dispositioncode where dispositioncode = 'Accepted'
select jsondata,* from intakesnapshot
WHERE intakenumber = 'I251013199751' AND activeflag=1;
*/

UPDATE intakesnapshot
set updatedby = 'CDM-43622',
	updatedon = now(),
	jsondata = jsonb_set(jsondata, '{DAType}',
		jsonb_set(jsondata->'DAType', '{DATypeDetail}',
		jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
		jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"')))
		)
WHERE intakenumber = 'I251013199751' AND activeflag=1;

/*
select jsondata,* from intakedastaging
WHERE intakenumber = 'I251013199751' AND activeflag=1;
*/

UPDATE intakedastaging
SET status = 'Closed',
    updatedby = 'CDM-43622',
    updatedon = now(),
    jsondata = jsonb_set(
        jsonb_set(
            jsondata, '{DAType,DATypeDetail,0}',
            jsonb_set(
                jsonb_set(
                    jsondata->'DAType'->'DATypeDetail'->0,
                    '{supDisposition}', '"ScreenOUT"'::jsonb
                ),
                '{supStatus}', '"Approved"'::jsonb
            )
        ),
        '{disposition,0}',
        jsonb_set(
            jsonb_set(
                jsondata->'disposition'->0,
                '{supDisposition}', '"ScreenOUT"'::jsonb
            ),
            '{supStatus}', '"Approved"'::jsonb
        )
    )
WHERE intakenumber = 'I251013199751' 
AND activeflag = 1;

/*
select supervisordecision,updatedby,fromsecurityusersid,tosecurityusersid,* from routing where objectid = 'I251013199751' and activeflag =1;
select * from userprofile where securityusersid = 'fc251376-8745-4381-a750-6a617c748678'
--from: 9c424094-8dc4-4015-9a32-3a7020615f11 --kim

select * from routing where routingid = 'f05d81ae-5b6c-47b3-a275-d15dd878507c'
*/
update routing set routingstatustypeid =8,
	supervisordecision = 'ScreenOUT',
	updatedby = 'fc251376-8745-4381-a750-6a617c748678'
where objectid='I251013199751' and activeflag=1;

/*
select intakeservicerequestclassid,* from intakeservicerequest where servicerequestnumber = '251022973737'; --isID:679cc5a5-9447-498b-9825-778e14db319f
select activeflag,routingstatustypeid,routingid,supervisordecision,* from routing where objectid = '679cc5a5-9447-498b-9825-778e14db319f' and activeflag = 1;
*/

-- routingid: 6d5d39d5-968a-43c2-b302-1ef9ffb95b9e

update routing
set activeflag = 0, updatedby = 'CDM-43622', updatedon = now() 
where objectid = '679cc5a5-9447-498b-9825-778e14db319f' and activeflag = 1;

--remove the case
update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-43622', updatedon = now() 
where intakeserviceid = '679cc5a5-9447-498b-9825-778e14db319f';

/*
select * from personprogramarea where objectid = '679cc5a5-9447-498b-9825-778e14db319f' and activeflag = 1;
*/
UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-43622'
WHERE objectid = '679cc5a5-9447-498b-9825-778e14db319f' and activeflag = 1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-43622', updatedon = now() 
where objectid = '679cc5a5-9447-498b-9825-778e14db319f' and activeflag = 1;