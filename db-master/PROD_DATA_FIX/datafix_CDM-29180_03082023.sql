/*
   Issue Description: CDM-29180
   Category/ Module  :  closing Service Case
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select * from servicecase where servicecaseid ='b578b35a-5dfd-46f8-bedc-23e676309e7f';

update servicecase 
set enddate=now(), statustypekey='Closed', updatedon=now(), updatedby='CDM-29180'
where servicecaseid ='b578b35a-5dfd-46f8-bedc-23e676309e7f';

INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('b578b35a-5dfd-46f8-bedc-23e676309e7f'::uuid, now(), 'Closed', 'Closed', 'closed', now(), 1, 'CDM-29180', now(), 'CDM-29180', now(), NULL, NULL, NULL, NULL);

-- "securityuserid":"299210ac-c6df-4985-a02b-bdeda0cdad67"
select securityusersid, supervisorid from userprofile where securityusersid = '299210ac-c6df-4985-a02b-bdeda0cdad67';

-- fromsecurityusersid, tosecurityusersid is from above securityusersid, supervisorid
INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '299210ac-c6df-4985-a02b-bdeda0cdad67', '40cec86d-311c-44f5-a9fe-6b5ba723d94d', 'CWSP', 'CWCW', 
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='b578b35a-5dfd-46f8-bedc-23e676309e7f'
		and updatedby ='CDM-29180' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-29180', now(), 'CDM-29180', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);