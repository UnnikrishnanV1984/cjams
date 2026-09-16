/*
   Issue Description: CDM-35768
   Category/ Module  : Prod data fix to case connect
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update intakeservicerequest set servicecaseid='7e428ebd-f2eb-4cc5-a3e5-4c74f5e5bbe9' where intakenumber = 'I231011548804';

INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES('c1643bcf-2a17-4ba6-954c-91d7f68259c3', 'b8ca42bd-540c-40a4-b5ad-6e568e41a3af', NULL, '027ec556-25bb-41a2-8058-ead774a387a5', NULL, NULL, 'da05e9ba-53cc-4d83-9dfa-6390a161a2a5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '027ec556-25bb-41a2-8058-ead774a387a5', 'CDM-35768', '2023-11-22 14:33:00.000', '2023-12-18 11:39:12.834', 'servicecase', '7e428ebd-f2eb-4cc5-a3e5-4c74f5e5bbe9', 'family', 1, '2023-11-22 14:33:00.000', NULL, 'b3e66a90-4bdd-45b3-a1cd-073c3665d6be', 'ad08cf0a-70cf-4b27-8aad-c0b49adc8b2f', NULL, NULL, 'c81be790-a79d-40ac-a38d-abd4dd5a81f6', 'c81be790-a79d-40ac-a38d-abd4dd5a81f6', 'W', NULL, '2023-11-22 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES('cc28d6f7-86f1-401f-b812-23af8d5375bf', '7e428ebd-f2eb-4cc5-a3e5-4c74f5e5bbe9', '2023-11-22 14:33:00.000', 'Open', 'Inprogress', 'Case Accepted', '2023-11-22 14:33:00.000', 1, '027ec556-25bb-41a2-8058-ead774a387a5', '2023-11-22 14:33:00.000', 'CDM-35768', '2023-12-18 11:41:20.003', NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('dfd95dba-565f-4372-aebf-fb4cf5f76d8d', 'SCDR', '027ec556-25bb-41a2-8058-ead774a387a5', NULL, NULL, NULL, NULL, 'cc28d6f7-86f1-401f-b812-23af8d5375bf', 16, 1, '027ec556-25bb-41a2-8058-ead774a387a5', '2023-11-22 14:33:00.000', 'CDM-35768', '2023-12-18 11:43:36.404', false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


update servicecase set enddate=null, updatedon = now(),updatedby = 'CDM-35768' 
where servicecaseid='7e428ebd-f2eb-4cc5-a3e5-4c74f5e5bbe9' and servicecasenumber='2021011607492'
