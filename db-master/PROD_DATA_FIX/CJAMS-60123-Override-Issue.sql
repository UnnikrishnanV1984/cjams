/*
   Issue Description: CJAMS-60123
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
WHERE intakenumber = 'I251013298714' AND activeflag=1;
*/

UPDATE intakesnapshot
set updatedby = 'CJAMS-60123',
	updatedon = now(),
	jsondata = jsonb_set(jsondata, '{DAType}',
		jsonb_set(jsondata->'DAType', '{DATypeDetail}',
		jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
		jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"')))
		)
WHERE intakenumber = 'I251013298714' AND activeflag=1;

/*
select jsondata,* from intakedastaging
WHERE intakenumber = 'I251013298714' AND activeflag=1;
*/

UPDATE intakedastaging
SET status = 'Closed',
    updatedby = 'CJAMS-60123',
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
WHERE intakenumber = 'I251013298714' 
AND activeflag = 1;

/*
select supervisordecision,updatedby,fromsecurityusersid,tosecurityusersid,* from routing where objectid = 'I251013298714' and activeflag =1;

select * from routing where routingid = '7e8ba63d-0fcf-4d63-b777-4f3c6b9fd210'
*/
update routing set routingstatustypeid =8,
	supervisordecision = 'ScreenOUT'
where objectid='I251013298714' and activeflag=1;

/*
select intakeservicerequestclassid,* from intakeservicerequest where servicerequestnumber = '251023069220'; --isID:8b3b1a48-fcc1-4c2c-bca5-3bddfa424ae2
select activeflag,routingstatustypeid,routingid,supervisordecision,* from routing where objectid = '8b3b1a48-fcc1-4c2c-bca5-3bddfa424ae2' and activeflag = 1;
*/

/*
 * no routing record for the CPS ir case

update routing
set activeflag = 0, updatedby = 'CJAMS-60123', updatedon = now() 
where objectid = '8b3b1a48-fcc1-4c2c-bca5-3bddfa424ae2' and activeflag = 1;
*/

--remove the case
update intakeservicerequest 
set activeflag = 0, updatedby = 'CJAMS-60123', updatedon = now() 
where intakeserviceid = '8b3b1a48-fcc1-4c2c-bca5-3bddfa424ae2';

/*
select * from personprogramarea where objectid = '8b3b1a48-fcc1-4c2c-bca5-3bddfa424ae2' and activeflag = 1;
*/
UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CJAMS-60123'
WHERE objectid = '8b3b1a48-fcc1-4c2c-bca5-3bddfa424ae2' and activeflag = 1;

update caseassignment
set activeflag = 0, updatedby = 'CJAMS-60123', updatedon = now() 
where objectid = '8b3b1a48-fcc1-4c2c-bca5-3bddfa424ae2' and activeflag = 1;