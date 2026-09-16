/*
Issue Description: CPS Background in review status on summary screen
Category/Module: Support
Root cause: Issue is not replicable, so requested to add the submission history and also to modify the case status in person search as data fix
Fix provided: Data fix is done to insert the submission record and also to midify the status of the case in person search
Data/Code fix ticket#: CJAMS-65475
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
values('INTR', '7dfc12b8-8342-48bc-9e20-ef2a313dd491', 'c4d0b6a8-99c0-4d7e-b6ff-859618c9d4ae', 'ee40a757-5378-409f-a7c6-118368415a99'::uuid, 'CWSP', 'CWSP', 'I261013899982', 8, 0, '7dfc12b8-8342-48bc-9e20-ef2a313dd491', now(), '7dfc12b8-8342-48bc-9e20-ef2a313dd491', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Closed', '', now());


update IntakeServiceRequest
set intakeserreqstatustypeid ='642f18b0-ef6e-4d4b-9871-acc0734f3f5a',
updatedby ='CJAMS-65475',updatedon =now()
where intakenumber = 'I261013899982' and activeflag =1;