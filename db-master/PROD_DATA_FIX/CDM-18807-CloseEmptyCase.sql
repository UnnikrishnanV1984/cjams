/*
   Issue Description: CDM-18807
   Category/ Module  : close empty case
   Root cause: user wants to close the status of case
   Pull request# for code fix: 4638
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('b9375486-4cd0-4834-a7bd-826f3e1122f5', '1b1a8348-6050-49ff-9b1c-799c78c79328'::uuid, now(), 'Closed', 'Closed', '', now(), 1, 'CDM-18807', now(), 'CDM-18807', now(), NULL, NULL, NULL, NULL) ;

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '72ea08ae-678a-423d-ae3a-44921d219c5e', null, null, null, null,  'b9375486-4cd0-4834-a7bd-826f3e1122f5', 16, 1, 'CDM-18807', now(), 'CDM-18807', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


update servicecase 
set enddate= now(), statustypekey='Closed', dispositioncode = 'Closed', updatedon=now(), updatedby='CDM-18807'
where servicecaseid ='1b1a8348-6050-49ff-9b1c-799c78c79328';
