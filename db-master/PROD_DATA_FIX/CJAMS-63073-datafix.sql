/*
Issue Description: CJAMS-63073
Category/Module: Computer glitch
Root cause: Data fix to update the status and verify the intake is not displaying in the supervisor dashbaord.
Fix provided:  Data fix to update the status and verify the intake is not displaying in the supervisor dashbaord.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix 
*/

update intakeservicerequest 
set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a',
    updatedby = 'CJAMS-63073',
	updatedon = now()
where intakenumber = 'I241013157599'
and intakeserviceid = 'f8fb805f-d3d8-4b73-9ed1-afa2dc7ba2a6'
and activeflag = 1;

update routing 
 set routingstatustypeid = 8,
     activeflag = 0
where routingid = 'e7bbcd00-b488-46bf-9678-65232afe60f6'
 and objectid = 'I241013157599';