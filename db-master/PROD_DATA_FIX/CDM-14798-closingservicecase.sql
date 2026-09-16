/*
   Issue Description: CDM-14798
   Category/ Module  :  closing Service Case
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update servicecase 
set enddate='2021-05-05 00:00:00', statustypekey='Closed', updatedon=now(), updatedby='CDM-14798'
where servicecaseid ='90a65d16-2b95-4419-bec2-89ea060fd8ae';

INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('90a65d16-2b95-4419-bec2-89ea060fd8ae'::uuid, '2021-05-05 00:00:00', 'Closed', 'Closed', 'closed', '2021-05-05 00:00:00', 1, 'CDM-14798', now(), 'CDM-14798', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', 'c4e33509-8fd7-40d4-918b-c97764e8f473', '1cd00092-f0ee-44ab-b02b-1fe518c5bc6e', 'CWSP', 'CWCW', 
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='90a65d16-2b95-4419-bec2-89ea060fd8ae'
		and updatedby ='CDM-14798' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-14798', now(), 'CDM-14798', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
