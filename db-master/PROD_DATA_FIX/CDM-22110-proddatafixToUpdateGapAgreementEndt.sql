
/*
   Issue Description: CDM-22010
   Category/ Module  : Prod data fix To update agreement end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- Rejected	2022-04-22 04:00:00
update gapagreementrate set status = 'Approved', enddate = '2023-02-22 05:00:00', updatedby = 'CDM-22110',rateapprovaldate = now() , updatedon = now() 
where gapagreementrateid = 'dbf6b9c7-af21-4538-b33b-57f73bd6f1a5';

--3045	2022-04-22 04:00:00
update gapratesrevision set approvalstatustypekey = '3047', rateenddate = '2023-02-22 05:00:00', approvaldate = now(), updatedon = now(), updatedby = 'CDM-22110'
where gaprateid ='dbf6b9c7-af21-4538-b33b-57f73bd6f1a5';

update routing set activeflag = 1, updatedby = 'CDM-22110', updatedon = now()  where routingid in ('99a1619c-1d68-40fe-aabf-12d6e951eb53', '82b1e4eb-3cee-43fd-aaf8-76c6fdf47cbb') and activeflag = 1;

INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('GARR', '3ca8e63d-f885-445b-aab9-24456e91ad4a', '9a46ffc9-4749-4289-998d-b56ea575ea35', 'b50f2419-42ba-4ab6-84ab-5172917d2d77'::uuid, 'CWSP', 'CWCW', 'dbf6b9c7-af21-4538-b33b-57f73bd6f1a5', 16, 1, 'CDM-22110', Now(), 'CDM-22110', now(), true, 'wrong dates ', NULL, 'Guardianship Rate Approved ', '3283171', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
