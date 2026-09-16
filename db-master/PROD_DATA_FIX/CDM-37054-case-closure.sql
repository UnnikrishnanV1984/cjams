/*
   Issue Description: CDM-37054
   User requested to move the case to closure as there is no Initial face to face contact.

    -- 'd803c8b4-c5f6-4e42-b945-6af888cbe1db',-- supervisor (Omolara Kasumu)
    -- 'f0d0cac0-de8c-4014-9f2a-4d1757e702fd' -- caseworker (Angela Pennix)
    --  Case#: 231021635984 (9c319c2e-3485-4d1c-adc2-f18692401443)

   Category/ Module  : case closure
   Root cause: The worker is not able to send the case for closure as they are not able to complete contact with one of the children.
   Resolution: Data fix is provided to close the case.
   Pull request# for code fix: 
   explanantion: user wants to reopen  AR case
  */

-- Backup
select intakeserreqstatustypeid,updatedby,updatedon from intakeservicerequest
where intakeserviceid = '9c319c2e-3485-4d1c-adc2-f18692401443' and activeflag = 1;

--UPDATE cjams.intakeservicerequest
-- SET intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690'::uuid, updatedby='cwResponseTm', updatedon='2024-02-02 16:43:27.489' where intakeserviceid = '9c319c2e-3485-4d1c-adc2-f18692401443' and activeflag = 1;

-- Update
update
   intakeservicerequest 
set
   intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-37054', updatedon = now() 
where
   intakeserviceid = '9c319c2e-3485-4d1c-adc2-f18692401443' and activeflag=1;

-- Backup
-- securityusersid :: f0d0cac0-de8c-4014-9f2a-4d1757e702fd
select securityusersid,* from userprofile where firstname = 'Angela' and lastname = 'Pennix';
-- securityusersid :: d803c8b4-c5f6-4e42-b945-6af888cbe1db
select securityusersid,* from userprofile where firstname = 'Omolara' and lastname = 'Kasumu';

select activeflag,updatedby,updatedon,intakeserreqstatustypeid,intakeservicerequestdispositioncodeid,* 
from intakeservicerequestdispositioncode where 
intakeserviceid = '9c319c2e-3485-4d1c-adc2-f18692401443' 
and intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690';

select activeflag,* from routing where servicerequestnumber = '231021635984' 
and activeflag = 1 and eventcode in ('INDR', 'INVT');

INSERT INTO
	cjams.intakeservicerequestdispositioncode (intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon,
	updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid,
	servicerequesttypeconfigiddispostionid, 
	reviewcomments, 
	reasonfordelay) 
VALUES
	('391159cb-f7a6-4217-a9f3-1b5d703f0ed0', '9c319c2e-3485-4d1c-adc2-f18692401443', 'd803c8b4-c5f6-4e42-b945-6af888cbe1db', '2024-02-12 00:00:00.000',
		'CDM-37054', NOW(), '2024-02-12 00:00:00.000', 'Completed', '2024-02-12 00:00:00.000', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8',
		'd90db0d3-f665-49db-b3ad-0edb468bc02d', 
		'Worker unable to interview the child due to child runaway status. CJAMS ticket submitted to assist with case closure.', 
		'');

select * from intakeservicerequestdispositioncode where updatedby = 'CDM-37054';

INSERT INTO
	cjams.routing (routingid, eventcode, fromsecurityusersid,
	tosecurityusersid, teamid, fromroleid, toroleid,
	objectid, 
	routingstatustypeid, activeflag,
	insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, routeddescription, servicerequestnumber) 
VALUES
   (
      cjams.gen_random_uuid(), 'INDR', 'f0d0cac0-de8c-4014-9f2a-4d1757e702fd', 
		'f0d0cac0-de8c-4014-9f2a-4d1757e702fd','3036bbf4-25b7-4392-8812-dd534908f864', 'CWCW', 'CWSP',
		(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = '9c319c2e-3485-4d1c-adc2-f18692401443' 
				and updatedby = 'CDM-37054'), 
		15, 0,
		'f0d0cac0-de8c-4014-9f2a-4d1757e702fd', '2024-02-12 00:00:00.000', 'CDM-37054', now(), true, '',
		'', '231021635984');

INSERT INTO
   cjams.routing (routingid, eventcode, fromsecurityusersid,
   tosecurityusersid, teamid, fromroleid, toroleid,
   objectid, routingstatustypeid, activeflag,
   insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey,
   old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes) 
VALUES
   (
      cjams.gen_random_uuid(), 'INDR', 'd803c8b4-c5f6-4e42-b945-6af888cbe1db', 
      'f0d0cac0-de8c-4014-9f2a-4d1757e702fd','3036bbf4-25b7-4392-8812-dd534908f864', 'CWSP', 'CWCW',
      (select intakeservicerequestdispositioncodeid from cjams.intakeservicerequestdispositioncode where
       intakeserviceid = '9c319c2e-3485-4d1c-adc2-f18692401443' and updatedby = 'CDM-37054'), 16, 1,
      'f0d0cac0-de8c-4014-9f2a-4d1757e702fd', '2024-02-12 00:01:00.000', 'CDM-37054', now() + interval '1 min', true, '',
      NULL, '', '231021635984', NULL,
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
   );

select * from routing where updatedby = 'CDM-37054';

-- Backup
select enddate,* from caseassignment where objectid = '9c319c2e-3485-4d1c-adc2-f18692401443' and enddate is null;


-- UPDATE cjams.caseassignment
-- SET enddate=NULL, updatedby='99a068e8-c725-4835-9aee-0712f9d4021c', updatedon='2023-12-20 10:31:00.534' 
-- where caseassignmentid = 'b51ec3c8-c3de-4df7-b621-509b58307309';


-- Update
update
   caseassignment 
set
   enddate = '2024-02-12 00:00:00.000', updatedby = 'CDM-37054', updatedon = now() 
where
   caseassignmentid = 'b51ec3c8-c3de-4df7-b621-509b58307309';


--Updating the end date and updtaedby in person
-- Backup
select enddate,* from personprogramarea where entityid = '231021635984';

-- UPDATE cjams.personprogramarea
-- SET enddate=NULL, updatedby='acdceddb-659f-487c-a18c-bae2b5e10b90', updatedon='2023-12-19 20:35:49.477'where personprogramid='2d160f8d-30c0-44a7-bbb3-c8e113bd961a'::uuid;
-- UPDATE cjams.personprogramarea
-- SET enddate=NULL, updatedby='acdceddb-659f-487c-a18c-bae2b5e10b90', updatedon='2023-12-19 20:35:49.477' where personprogramid='edc52db7-3f3d-4f0e-a82f-a46fe4d8b200'::uuid;
-- UPDATE cjams.personprogramarea
-- SET enddate=NULL, updatedby='acdceddb-659f-487c-a18c-bae2b5e10b90', updatedon='2023-12-19 20:35:49.477' where personprogramid='d6842cb2-2bbb-4472-bf45-4f7ae4bf9b14'::uuid;
-- UPDATE cjams.personprogramarea
-- SET enddate=NULL, updatedby='acdceddb-659f-487c-a18c-bae2b5e10b90', updatedon='2023-12-19 20:35:49.477' where personprogramid='f781e0fc-a347-4e56-8793-5e099e4f7cb9'::uuid;

-- Update
update
   personprogramarea 
set
   enddate = '2024-02-12 00:00:00.000', updatedby = 'CDM-37054', updatedon = now()
where
   entityid = '231021635984' 
   and activeflag = 1 
   and enddate is null;

-- without checking the Initial face to face checkbox in the review checklist.

select * from legislative where updatedby in ('CDM-37054');

INSERT INTO cjams.legislative
(legislativeid, intakeserviceid, isapprovedsafec, activeflag, updatedby, updatedon, 
insertedby, insertedon, isinitialfacetoface, isapprovedmfira, isapprovecansf,
isvictimperpetrator, isallpersons, isallegedvicitm, isemergency, islegislativereporting, 
isreasonnotprovided, isdataentrynotes, islateinitialcontact)
VALUES('b08048f1-3cd1-4e27-9127-848585afc49d', '9c319c2e-3485-4d1c-adc2-f18692401443', true, 1, 'CDM-37054', now(), 
'd803c8b4-c5f6-4e42-b945-6af888cbe1db', now(), NULL, true, true, 
true, true, NULL, '', Null, 
'', '', true);