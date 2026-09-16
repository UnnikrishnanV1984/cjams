/*
   Issue Description: CJAMS-58386
   Category/ Module  : Child Welfare
   Root cause: Delete this CPS AR case and screen Out the Intake decision.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/ 
-- screening out the intake
/*
select jsondata,* from intakesnapshot
WHERE intakenumber = 'I251013244059' AND activeflag=1;
*/

UPDATE intakesnapshot
set updatedby = 'CJAMS-58386',
	updatedon = now(),
	jsondata = jsonb_set(jsondata, '{DAType}',
		jsonb_set(jsondata->'DAType', '{DATypeDetail}',
		jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
		jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"')))
		)
WHERE intakenumber = 'I251013244059' AND activeflag=1;

/*
select jsondata,* from intakedastaging
WHERE intakenumber = 'I251013244059' AND activeflag=1;
*/

UPDATE intakedastaging
SET status = 'Closed',
	updatedby = 'CJAMS-58386',
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
WHERE intakenumber = 'I251013244059' 
AND activeflag = 1;

-- submisiion status to be closed and supervisior decision to be screenOUT
/*
select supervisordecision,updatedby,fromsecurityusersid,tosecurityusersid,* from routing where objectid = 'I251013244059' and activeflag =1;
select * from routing where routingid = 'f05d81ae-5b6c-47b3-a275-d15dd878507c'
*/

update routing set routingstatustypeid =8,
	supervisordecision = 'ScreenOUT'
where objectid='I251013244059' and activeflag=1;

/*
select * from intakeservicerequest where intakeserviceid = '25f25a23-427f-4c74-b513-35f46e256370'
*/
--remove the case
update intakeservicerequest 
set activeflag = 0, updatedby = 'CJAMS-58386', updatedon = now() 
where intakeserviceid = '25f25a23-427f-4c74-b513-35f46e256370';

/*
select * from personprogramarea where objectid = '25f25a23-427f-4c74-b513-35f46e256370' and activeflag = 1;
*/

UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CJAMS-58386'
WHERE objectid = '25f25a23-427f-4c74-b513-35f46e256370' and activeflag = 1;

--no record in caseassignment
--update caseassignment
--set activeflag = 0, updatedby = 'CJAMS-58386', updatedon = now() 
--where objectid = '25f25a23-427f-4c74-b513-35f46e256370' and activeflag = 1;