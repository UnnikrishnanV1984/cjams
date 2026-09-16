/*
   Issue Description: CJAMS-60124
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
WHERE intakenumber = 'I251013295988' AND activeflag=1;
*/

UPDATE intakesnapshot
set updatedby = 'CJAMS-60124',
	updatedon = now(),
	jsondata = jsonb_set(jsondata, '{DAType}',
		jsonb_set(jsondata->'DAType', '{DATypeDetail}',
		jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
		jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"')))
		)
WHERE intakenumber = 'I251013295988' AND activeflag=1;

/*
select jsondata,* from intakedastaging
WHERE intakenumber = 'I251013295988' AND activeflag=1;
*/

UPDATE intakedastaging
SET status = 'Closed',
    updatedby = 'CJAMS-60124',
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
WHERE intakenumber = 'I251013295988' 
AND activeflag = 1;

/*
select supervisordecision,updatedby,fromsecurityusersid,tosecurityusersid,* from routing where objectid = 'I251013295988' and activeflag =1;
select * from userprofile where securityusersid = 'fc251376-8745-4381-a750-6a617c748678'
--from: 9c424094-8dc4-4015-9a32-3a7020615f11 --kim

select * from routing where routingid = 'f05d81ae-5b6c-47b3-a275-d15dd878507c'
*/
update routing set routingstatustypeid =8,
	supervisordecision = 'ScreenOUT'
where objectid='I251013295988' and activeflag=1;

/*
select intakeservicerequestclassid,* from intakeservicerequest where servicerequestnumber = '251023069210'; --isID:bbf55cbf-a2f1-4eb9-ba77-6e6ada8ad1d9
select activeflag,routingstatustypeid,routingid,supervisordecision,* from routing where objectid = 'bbf55cbf-a2f1-4eb9-ba77-6e6ada8ad1d9' and activeflag = 1;
*/

-- routingid: 6d5d39d5-968a-43c2-b302-1ef9ffb95b9e

update routing
set activeflag = 0, updatedby = 'CJAMS-60124', updatedon = now() 
where objectid = 'bbf55cbf-a2f1-4eb9-ba77-6e6ada8ad1d9' and activeflag = 1;

--remove the case
update intakeservicerequest 
set activeflag = 0, updatedby = 'CJAMS-60124', updatedon = now() 
where intakeserviceid = 'bbf55cbf-a2f1-4eb9-ba77-6e6ada8ad1d9';

/*
select * from personprogramarea where objectid = 'bbf55cbf-a2f1-4eb9-ba77-6e6ada8ad1d9' and activeflag = 1;
*/
UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CJAMS-60124'
WHERE objectid = 'bbf55cbf-a2f1-4eb9-ba77-6e6ada8ad1d9' and activeflag = 1;

update caseassignment
set activeflag = 0, updatedby = 'CJAMS-60124', updatedon = now() 
where objectid = 'bbf55cbf-a2f1-4eb9-ba77-6e6ada8ad1d9' and activeflag = 1;