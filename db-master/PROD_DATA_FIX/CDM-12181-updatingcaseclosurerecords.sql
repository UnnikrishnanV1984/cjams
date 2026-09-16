update servicecase 
set enddate='2021-04-08 09:00:00', statustypekey='Closed', updatedon=now(), updatedby='CDM-12181'
where servicecaseid ='7a43626b-c5bf-4a54-ba02-9b79580df6e3';


INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('7a43626b-c5bf-4a54-ba02-9b79580df6e3'::uuid, '2021-04-08 09:00:00', 'Closed', 'Closed', 'ROA from out of state - Pennsylvania for basic safety check. Did not request Safe-C or MFIRA. Safety Note sent to Requesting Agency'
, '2021-04-08 09:00:00', 1, 'f256a041-3d12-4c0a-aa9f-d839e29ef073', now(), 'CDM-12181', now());


INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest)
VALUES('SCDR', '96c95c04-2bc7-4d70-a923-262b748b275f',
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='7a43626b-c5bf-4a54-ba02-9b79580df6e3' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-12181', now(), 'CDM-12181', now(), true);
