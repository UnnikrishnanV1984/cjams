update personprogramarea set enddate = '2020-08-31 00:00:00',updatedby = 'CDM-11789',updatedon = now() where personprogramid = '6cddb141-0131-46c3-b3f9-fea99f5cf80b' and entityid = '3123158';

-- Updating Legal Custody End date
update legalcustody set todate = '2020-06-26 00:00:00',updatedby = 'CDM-11789',updatedon = now()  where legalcustodyid = 'accd0974-85fd-4583-a654-3b1565d81ac7';

-- Inserting service case Decision

INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('8c287816-65a3-493b-ad32-680673eaab3b'::uuid, '2020-08-31 00:00:00.000', 'Closed', 'Closed', 'Case needs to be closed since the child is no longer eligible for the services.', now(), 1, 'CDM-11789', now(), 'CDM-11789', now());


INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest)
VALUES('SCDR', '362086ed-9366-451c-b7c1-b623d6de193b',
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='8c287816-65a3-493b-ad32-680673eaab3b'
		and updatedby ='CDM-11789' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11789', now(), 'CDM-11789', now(), true);