-- Reopen case 3296842
INSERT INTO cjams.servicecasedisposition
( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", 
effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('f26e21c7-f118-42e5-b388-96ca3e40ab8a', '2020-11-27 12:00:00.000', 'Reopen', 'Inprogress', 'Attaching to 20200279039878 for ongoing service with in-home unit', 
'2020-11-27 12:15:13.000', 1, 'd6c2ad8f-ab3f-4420-9287-2aab0c338f48', now(), '309d6683-8cbe-4d52-8c6f-7035bc0f1db9', now(), NULL, '3296842', NULL, NULL);

--routing

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
insertedby, insertedon, updatedby, updatedon, isreviewrequest, servicerequestnumber, objecttypekey)
VALUES('SCDR', '309d6683-8cbe-4d52-8c6f-7035bc0f1db9', 'd6c2ad8f-ab3f-4420-9287-2aab0c338f48', NULL, 'CWSP', 'CWCW', 
(SELECT servicecasedispositionid FROM servicecasedisposition WHERE servicecaseid = 'f26e21c7-f118-42e5-b388-96ca3e40ab8a'
AND intakeserreqstatustypekey = 'Reopen' ORDER BY insertedon DESC LIMIT 1),
16, 1, '309d6683-8cbe-4d52-8c6f-7035bc0f1db9', now(), '309d6683-8cbe-4d52-8c6f-7035bc0f1db9', now(), false, '3296842','servicerequest' );

--CDM-3637 team id is updated Consolidated Family Preservation to Interagency Family Preservation Unit

UPDATE caseassignment SET toteamid = '6971b56a-ce02-4e47-8a09-305c2b9fb5ab', updatedon = now(), updatedby = 'CDM-3637' WHERE 
toteamid = '5fed07ee-4d3f-4390-bd5b-825c437ef1b8' ;

UPDATE caseassignment SET fromteamid = '6971b56a-ce02-4e47-8a09-305c2b9fb5ab', updatedon = now(), updatedby = 'CDM-3637' WHERE 
fromteamid = '5fed07ee-4d3f-4390-bd5b-825c437ef1b8' ;

--CDM7531 -- intake routing I202000596113

UPDATE routing SET  eventcode = 'INTR', activeflag = 1, updatedon = now(), 
updatedby = 'CDM-7531'WHERE routingid = 'a2948264-fadf-47e4-bb47-7889b81dbad0' AND objectid = 'I202000596113' ;

UPDATE IntakeDAStaging SET status = 'pending', ispreintake=false WHERE intakenumber = 'I202000596113' AND activeflag = 1 ;

