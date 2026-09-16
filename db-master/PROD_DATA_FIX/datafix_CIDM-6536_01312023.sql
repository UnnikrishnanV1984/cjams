-- CIDM-6536 - Case Closure Data Fix
/*
-- Issue Description: 
  User request to Close below 2 CPS Cases

-- CPS-AR: 2020051015881 - a7e0be1c-78db-4a26-8128-6cbbeb2f1203
-- Requested by: Maureen Wahl - 1f56edc2-357f-44eb-b07e-c3bdb21aface
-- Approved by: Tracy Enriquez - f758b860-0a83-4aac-8157-87267159abcf
-- Case Closure Date & Time: 2/24/2020

-- CPS-IR: 2020043015618 - 465b0e19-5c80-4b58-8147-4203e045a521
-- Requested by: Maureen Wahl - 1f56edc2-357f-44eb-b07e-c3bdb21aface
-- Approved by: Tracy Enriquez - f758b860-0a83-4aac-8157-87267159abcf
-- Case Closure Date & Time 2/25/2020

-- Category/ Module: GAP (Case Management) 
-- Root cause: Flaw in the code, code fix has been promoted as a part of this defect. 
-- Fix Provided: Datafix has been promoted to Close the requested CPS cases
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Delete  
select count(*) from routing where insertedby = 'CIDM-6536';
delete from routing where insertedby = 'CIDM-6536';

-- CPS-AR: 2020051015881 - a7e0be1c-78db-4a26-8128-6cbbeb2f1203
-- Requested by: Maureen Wahl - 1f56edc2-357f-44eb-b07e-c3bdb21aface
-- Approved by: Tracy Enriquez - f758b860-0a83-4aac-8157-87267159abcf
-- Case Closure Date & Time: 2/24/2020

select intakeserviceid, exitdate, updatedon, updatedby
	from intakeservicerequest 
where servicerequestnumber  = '2020051015881' ;

update intakeservicerequest
set exitdate = '2020-02-24 09:22:02.563',
	updatedon = now(),
	updatedby = 'CIDM-6536' 
where servicerequestnumber  = '2020051015881' ;	

-- d90db0d3-f665-49db-b3ad-0edb468bc02d	Recommend for closure
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '1f56edc2-357f-44eb-b07e-c3bdb21aface', 
		'f758b860-0a83-4aac-8157-87267159abcf', '5da69eb1-7274-4bb5-82ac-dfdc962c9e9a'::uuid, 
		'CWCW', 'CWSP', '6bb37306-d563-4172-a693-e1dd1c8ece15', 15, 0, 
		'CIDM-6536', '2020-02-24 09:20:02.563', 'CIDM-6536', '2020-02-24 09:20:02.563', 
		true, 'Disposition Request', NULL, 'Disposition Request', '2020051015881', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', 'f758b860-0a83-4aac-8157-87267159abcf', 
		'1f56edc2-357f-44eb-b07e-c3bdb21aface', '1be296ef-d018-4c25-ad8a-9f5070f5b115'::uuid, 
		'CWSP', 'CWCW', '6bb37306-d563-4172-a693-e1dd1c8ece15', 16, 1, 
		'CIDM-6536', '2020-02-24 09:22:02.563', 'CIDM-6536', '2020-02-24 09:22:02.563', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '2020051015881', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);

-- CPS-IR: 2020043015618 - 465b0e19-5c80-4b58-8147-4203e045a521
-- Requested by: Maureen Wahl - 1f56edc2-357f-44eb-b07e-c3bdb21aface
-- Approved by: Tracy Enriquez - f758b860-0a83-4aac-8157-87267159abcf
-- Case Closure Date & Time 2/25/2020

select intakeserviceid, exitdate, updatedon, updatedby
	from intakeservicerequest 
where servicerequestnumber  = '2020043015618' ;

update intakeservicerequest
set exitdate = '2020-02-25 09:22:02.563',
	updatedon = now(),
	updatedby = 'CIDM-6536' 
where servicerequestnumber  = '2020043015618' ;	

-- 05916d23-b704-4fb7-9ebf-9ab4380cd91d -- d90db0d3-f665-49db-b3ad-0edb468bc02d	Recommend for closure
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '1f56edc2-357f-44eb-b07e-c3bdb21aface', 
		'f758b860-0a83-4aac-8157-87267159abcf', '5da69eb1-7274-4bb5-82ac-dfdc962c9e9a'::uuid, 
		'CWCW', 'CWSP', '05916d23-b704-4fb7-9ebf-9ab4380cd91d', 15, 0, 
		'CIDM-6536', '2020-02-25 09:20:02.563', 'CIDM-6536', '2020-02-25 09:20:02.563', 
		true, 'Disposition Request', NULL, 'Disposition Request', '2020043015618', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', 'f758b860-0a83-4aac-8157-87267159abcf', 
		'1f56edc2-357f-44eb-b07e-c3bdb21aface', '1be296ef-d018-4c25-ad8a-9f5070f5b115'::uuid, 
		'CWSP', 'CWCW', '05916d23-b704-4fb7-9ebf-9ab4380cd91d', 16, 1, 
		'CIDM-6536', '2020-02-25 09:22:02.563', 'CIDM-6536', '2020-02-25 09:22:02.563', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '2020043015618', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
-- End date open CPS program assignmnets 
select personprogramid, entityid, programkey, subprogramkey, startdate, enddate, updatedon, updatedby,
	(select exitdate from intakeservicerequest where intakeserviceid  = objectid::uuid ) as new_end_date
from personprogramarea  
where programkey = 'CPS'
	and activeflag = 1
	and enddate is null
	and objectid 
		in ( select intakeserviceid::character varying
				from intakeservicerequest 
			where servicerequestnumber in ( '2020051015881', '2020043015618' )
				and activeflag  = 1
			) ;

update personprogramarea
set enddate = (select exitdate from intakeservicerequest where intakeserviceid  = objectid::uuid ),
	updatedon = now(),
	updatedby = 'CIDM-6536'
where programkey = 'CPS'
	and activeflag = 1
	and enddate is null
	and objectid 
		in ( select intakeserviceid::character varying
				from intakeservicerequest 
			where servicerequestnumber in ( '2020051015881', '2020043015618' )
				and activeflag  = 1
			) ;

-- CIDM-6406-R1
select personprogramid, entityid, programkey, subprogramkey, startdate, enddate, updatedon, updatedby,
	(select exitdate from intakeservicerequest where intakeserviceid  = objectid::uuid ) as new_end_date  
from personprogramarea
where programkey = 'CPS'
	and activeflag = 1
	and enddate  is null
	and objectid = '7d486e5b-5ec9-44e2-8827-3bd9980402cc' ;

update personprogramarea
set enddate = '2020-02-20 07:58:20.586',
	updatedon = now(),
	updatedby = 'CIDM-6406-R1'
where programkey = 'CPS'
	and activeflag = 1
	and enddate  is null
	and objectid = '7d486e5b-5ec9-44e2-8827-3bd9980402cc' ;
	
select caseassignmentid, responsibilitytypekey, startdate, enddate, updatedby, updatedon  
, (select exitdate from intakeservicerequest where intakeserviceid  = objectid::uuid ) as new_end_date
from caseassignment 
where activeflag = 1
	and enddate is null
	and objectid 
		in ( select intakeserviceid
				from intakeservicerequest 
			where servicerequestnumber  
				in ( '20200216027140', '2020034015187', '221020208070', '221020254022', '211020155880',
					'2021084095551', '2021057085725', '221020179575', '221020184705', '2021090097316',
					'221020181792', '221020190307', '20210990100298', '2021060086028', '202101030100955',
					'211020117707', '2021050083204', '211020118328', '2021081093764', '202101110103242',
					'202101100102660', '211020117884', '2021082094578', '211020120733', '2021085095931',
					'211020153156', '202101170104864', '202101230106109'
					)
				and activeflag  = 1
			) ;

update caseassignment
set enddate = (select exitdate from intakeservicerequest where intakeserviceid  = objectid::uuid ),
	updatedon = now(),
	updatedby = 'CIDM-6406-R1'
where activeflag = 1
	and enddate is null
	and objectid 
		in ( select intakeserviceid
				from intakeservicerequest 
			where servicerequestnumber  
				in ( '20200216027140', '2020034015187', '221020208070', '221020254022', '211020155880',
					'2021084095551', '2021057085725', '221020179575', '221020184705', '2021090097316',
					'221020181792', '221020190307', '20210990100298', '2021060086028', '202101030100955',
					'211020117707', '2021050083204', '211020118328', '2021081093764', '202101110103242',
					'202101100102660', '211020117884', '2021082094578', '211020120733', '2021085095931',
					'211020153156', '202101170104864', '202101230106109'
					)
				and activeflag  = 1
			) ;
			
-- CIDM-6406-R2
select caseassignmentid, responsibilitytypekey, startdate, enddate, updatedby, updatedon  
, (select exitdate from intakeservicerequest where intakeserviceid  = objectid::uuid ) as new_end_date
from caseassignment 
where activeflag = 1
	and enddate is null
	and objectid 
		in ( select intakeserviceid
				from intakeservicerequest 
			where servicerequestnumber  
				in ( '20200339060344', '221020188787', '221020218910', '20200169021461', '20200247032917',
					 '20200303047279', '20200300046101', '20200104017535'
					)

				and activeflag  = 1
			) ;
		
update caseassignment
set enddate = (select exitdate from intakeservicerequest where intakeserviceid  = objectid::uuid ),
	updatedon = now(),
	updatedby = 'CIDM-6406-R2'		
where activeflag = 1
	and enddate is null
	and objectid 
		in ( select intakeserviceid
				from intakeservicerequest 
			where servicerequestnumber  
				in ( '20200339060344', '221020188787', '221020218910', '20200169021461', '20200247032917',
					 '20200303047279', '20200300046101', '20200104017535'
					)

				and activeflag  = 1
			) ;		
		