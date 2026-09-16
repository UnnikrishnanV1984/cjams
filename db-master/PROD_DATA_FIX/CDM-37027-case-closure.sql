/*
   Issue Description: CDM-37027
   Category/ Module  : case closure
   Root cause: User requested to move the case to closure.
   Resolution: Data fix is provided to close the case.
   Pull request# for code fix: 
   explanantion: user wants to reopen  AR case
  */

-- Backup
select intakeserreqstatustypeid,updatedby,updatedon from intakeservicerequest
where intakeserviceid = '782b4502-7828-4734-aa70-5d625c8e5eeb' and activeflag = 1;

--UPDATE cjams.intakeservicerequest
--SET intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690'::uuid, 
--updatedby='e54c1a0d-f76c-4c59-b5f1-05479b62f02d', updatedon='2024-01-18 09:27:47.643' 
--where intakeserviceid = '782b4502-7828-4734-aa70-5d625c8e5eeb' and activeflag = 1;

-- Update
update
   intakeservicerequest 
set
   intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-37027', updatedon = now() 
where
   intakeserviceid = '782b4502-7828-4734-aa70-5d625c8e5eeb' and activeflag=1;

-- Backup
-- securityusersid :: d7e2da5b-44ba-43a4-9e47-008f84ef3d25
select securityusersid,* from userprofile where firstname = 'Valerie' and lastname = 'Heath';

select activeflag,updatedby,updatedon,intakeserreqstatustypeid,intakeservicerequestdispositioncodeid,* 
from intakeservicerequestdispositioncode where 
intakeserviceid = '782b4502-7828-4734-aa70-5d625c8e5eeb' 
and intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690';

select activeflag,* from routing where servicerequestnumber = '241021777980' 
and activeflag = 1 and eventcode in ('INDR', 'INVT');

-- securityusersid :: 256457bc-cd36-40ed-9716-c76835b9b8cc
select securityusersid,* from userprofile where firstname = 'Mia' and lastname = 'Dabney';

INSERT INTO
	cjams.intakeservicerequestdispositioncode (intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon,
	updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid,
	servicerequesttypeconfigiddispostionid, 
	reviewcomments, 
	reasonfordelay) 
VALUES
	('f5fb9f73-3256-4b5c-a4c8-900d428a2332', '782b4502-7828-4734-aa70-5d625c8e5eeb', '256457bc-cd36-40ed-9716-c76835b9b8cc', '2024-02-07 00:00:00.000',
		'CDM-37027', NOW(), '2024-02-08 00:00:00.000', 'Completed', '2024-02-08 00:00:00.000', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8',
		'd90db0d3-f665-49db-b3ad-0edb468bc02d', 
		'Worker unable to close case due to inability to meet with alleged victims. CJAMS ticket submitted', 
		'');

select * from intakeservicerequestdispositioncode where updatedby = 'CDM-37027';

-- '256457bc-cd36-40ed-9716-c76835b9b8cc',-- supervisor
-- 'd7e2da5b-44ba-43a4-9e47-008f84ef3d25' -- caseworker
INSERT INTO
	cjams.routing (routingid, eventcode, fromsecurityusersid,
	tosecurityusersid, teamid, fromroleid, toroleid,
	objectid, 
	routingstatustypeid, activeflag,
	insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, routeddescription, servicerequestnumber) 
VALUES
   (
      'ce1f41ce-0cba-478f-ab40-eaeee25b3d0b', 'INDR', 'd7e2da5b-44ba-43a4-9e47-008f84ef3d25', 
		'd7e2da5b-44ba-43a4-9e47-008f84ef3d25','862ff553-6c2c-4f28-89a2-69136865992a', 'CWCW', 'CWSP',
		(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = '782b4502-7828-4734-aa70-5d625c8e5eeb' 
				and updatedby = 'CDM-37027'), 
		15, 0,
		'd7e2da5b-44ba-43a4-9e47-008f84ef3d25', '2024-02-08 12:00:00.000', 'CDM-37027', now(), true, '',
		'', '241021777980');

INSERT INTO
   cjams.routing (routingid, eventcode, fromsecurityusersid,
   tosecurityusersid, teamid, fromroleid, toroleid,
   objectid, routingstatustypeid, activeflag,
   insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey,
   old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes) 
VALUES
   (
      '213dce70-93ed-4bce-bb93-aea63b5ed3ba', 'INDR', '256457bc-cd36-40ed-9716-c76835b9b8cc', 
      'd7e2da5b-44ba-43a4-9e47-008f84ef3d25','862ff553-6c2c-4f28-89a2-69136865992a', 'CWSP', 'CWCW',
      (select intakeservicerequestdispositioncodeid from cjams.intakeservicerequestdispositioncode where
       intakeserviceid = '782b4502-7828-4734-aa70-5d625c8e5eeb' and updatedby = 'CDM-37027'), 16, 1,
      'd7e2da5b-44ba-43a4-9e47-008f84ef3d25', '2024-02-08 12:00:00.000', 'CDM-37027', now(), true, '',
      NULL, '', '241021777980', NULL,
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
   );

select * from routing where updatedby = 'CDM-37027';

-- Backup
select enddate,* from caseassignment where objectid = '782b4502-7828-4734-aa70-5d625c8e5eeb' and enddate is null;

-- UPDATE cjams.caseassignment
-- SET objectid='782b4502-7828-4734-aa70-5d625c8e5eeb'::uuid, enddate=NULL, updatedby='256457bc-cd36-40ed-9716-c76835b9b8cc', updatedon='2024-01-11 08:59:44.175'
-- WHERE caseassignmentid='25a3cede-17ec-429c-8b44-1852dd405762'::uuid;

-- Update
update
   caseassignment 
set
   enddate = '2024-02-08 00:00:00.000', updatedby = 'CDM-37027', updatedon = now() 
where
   caseassignmentid = '25a3cede-17ec-429c-8b44-1852dd405762';


--Updating the end date and updtaedby in person
-- Backup
select enddate,* from personprogramarea where entityid = '241021777980';

-- UPDATE cjams.personprogramarea
-- SET personprogramid='c3d19795-1b21-4d4b-8ddd-2a0d6b6f9ba4'::uuid, enddate=NULL, updatedby=NULL, updatedon='2024-01-18 09:27:49.064' where personprogramid='c3d19795-1b21-4d4b-8ddd-2a0d6b6f9ba4';
-- UPDATE cjams.personprogramarea
-- SET personprogramid='e9ff8099-8da7-4f11-9365-7bb7e357591a'::uuid, enddate=NULL, updatedby=NULL, updatedon='2024-01-18 09:27:49.064' where personprogramid='e9ff8099-8da7-4f11-9365-7bb7e357591a';
-- UPDATE cjams.personprogramarea
-- SET personprogramid='542d1899-77df-4c73-ac73-47292de8a1dc'::uuid, enddate=NULL, updatedby=NULL, updatedon='2024-01-18 09:27:49.064' where personprogramid='542d1899-77df-4c73-ac73-47292de8a1dc';
-- UPDATE cjams.personprogramarea
-- SET personprogramid='48e565bd-3d36-4939-b892-edf948a5c861'::uuid, enddate=NULL, updatedby=NULL, updatedon='2024-01-18 09:27:49.064' where personprogramid='48e565bd-3d36-4939-b892-edf948a5c861';
-- UPDATE cjams.personprogramarea
-- SET personprogramid='ea74f0b4-8a86-4129-bc23-e0652a961987'::uuid, enddate=NULL, updatedby='e54c1a0d-f76c-4c59-b5f1-05479b62f02d', updatedon='2024-01-10 17:03:01.931' where personprogramid='ea74f0b4-8a86-4129-bc23-e0652a961987';
-- UPDATE cjams.personprogramarea
-- SET personprogramid='a4424b99-9ed5-40bb-806d-27c3c639fe22'::uuid, enddate=NULL, updatedby='e54c1a0d-f76c-4c59-b5f1-05479b62f02d', updatedon='2024-01-10 17:03:01.931' where personprogramid='a4424b99-9ed5-40bb-806d-27c3c639fe22';
-- UPDATE cjams.personprogramarea
-- SET personprogramid='7ccbea90-9de5-49b2-8ca1-7209c132c6fe'::uuid, enddate=NULL, updatedby='e54c1a0d-f76c-4c59-b5f1-05479b62f02d', updatedon='2024-01-10 17:03:01.931' where personprogramid='7ccbea90-9de5-49b2-8ca1-7209c132c6fe';
-- UPDATE cjams.personprogramarea
-- SET personprogramid='8d8bfdaf-07d2-45db-8c10-da1c5e1ae303'::uuid, enddate=NULL, updatedby='e54c1a0d-f76c-4c59-b5f1-05479b62f02d', updatedon='2024-01-10 17:03:01.931' where personprogramid='8d8bfdaf-07d2-45db-8c10-da1c5e1ae303';

-- Update
update
   personprogramarea 
set
   enddate = '2024-02-08 00:00:00.000', updatedby = 'CDM-37027', updatedon = now()
where
   entityid = '241021777980' 
   and activeflag = 1 
   and enddate is null;

-- without checking the Initial face to face checkbox in the review checklist.

select * from legislative where updatedby in ('CDM-37027');

INSERT INTO cjams.legislative
(legislativeid, intakeserviceid, isapprovedsafec, activeflag, updatedby, updatedon, 
insertedby, insertedon, isinitialfacetoface, isapprovedmfira, isapprovecansf,
isvictimperpetrator, isallpersons, isallegedvicitm, isemergency, islegislativereporting, 
isreasonnotprovided, isdataentrynotes, islateinitialcontact)
VALUES('72b7eaf3-c8bd-4919-b932-774132591c7d', '782b4502-7828-4734-aa70-5d625c8e5eeb', true, 1, 'CDM-37027', now(), 
'256457bc-cd36-40ed-9716-c76835b9b8cc', now(), NULL, true, true, 
true, true, NULL, '', Null, 
'', '', true);