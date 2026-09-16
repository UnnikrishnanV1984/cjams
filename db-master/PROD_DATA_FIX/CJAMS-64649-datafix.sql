/*
   Issue Description: CJAMS-64649 Approval
   Category/ Module  : Out-of-home
   Root cause: wrong YTP review records are showing up on the approvals Screen
   Fix provided: Data fix to delete the outstanding placement validation
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: wrong data
*/


update cjams.routing set activeflag =0, updatedby ='CJAMS-64649', updatedon = now()
where routingid in ('1cb1380b-fb2f-46ef-aa02-794c4c153959', '42558f4d-f0e7-4a5f-8d7f-f63ed9e5d60c')
and objectid = '380e0ba2-ed7d-4926-b97a-7c816527876a' 
and eventcode = 'YTP'and activeflag = 1;