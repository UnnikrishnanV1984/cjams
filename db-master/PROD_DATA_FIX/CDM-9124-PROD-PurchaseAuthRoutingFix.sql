update routing 
set insertedon = '2019-12-17'::date, updatedon =now(), updatedby ='CDM-9124'
where routingid ='c6856c3d-763e-44fa-8208-cf9ab052af1a';

update routing 
set tosecurityusersid ='8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40', activeflag =0, insertedon = '2019-12-18'::date, updatedon ='2019-12-18'::date, updatedby ='CDM-9124'
where routingid ='45a31e4c-5ae0-46f8-9380-67b9742e504f';

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('PCAUTHR', '8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40', '79d94b5d-d743-49ca-888f-da32661ce910', 'b1de819d-0f16-4f9e-a86d-d1b89d0474da', 'FNSFS', 'FNSFS', '738796', 43, 1, '8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40', '2019-12-19', '79d94b5d-d743-49ca-888f-da32661ce910', now(), true, 'Approved', NULL, NULL, '3223664', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

