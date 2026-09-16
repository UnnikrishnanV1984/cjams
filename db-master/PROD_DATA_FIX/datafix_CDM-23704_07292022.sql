-- CDM-23704 - Case Closing
/*
-- Issue Description: 
   To fix the CPS-AR ID: 221020217095 closure issue

-- Category/ Module: Program Assignment (Case Management) 
-- Root cause: TBD
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Close on 2022-07-12 15:42:46
select servicerequestnumber, exitdate, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '221020217095'
	and activeflag = 1 ;		 

update intakeservicerequest
set exitdate = '2022-07-12 15:42:46',
	updatedby = 'CDM-23704',
	updatedon = now()
where servicerequestnumber = '221020217095'
	and activeflag = 1 ;		 

-- Delete  
select ServiceRequestTypeConfigIdDispostionId, activeflag, updatedby, updatedon
	from intakeservicerequestdispositioncode
where intakeserviceid = 'dd820f47-2024-4857-9620-29d1520797b4'
	and intakeservicerequestdispositioncodeid = '984fcb3b-e418-4b78-a578-7b56200a56eb'
	and activeflag = 1 ;

update intakeservicerequestdispositioncode
set activeflag = 0,
	updatedby = 'CDM-23704',
	updatedon = now()
where intakeserviceid = 'dd820f47-2024-4857-9620-29d1520797b4'
	and intakeservicerequestdispositioncodeid = '984fcb3b-e418-4b78-a578-7b56200a56eb'
	and activeflag = 1 ;

select responsibilitytypekey, startdate, enddate, updatedby, updatedon
	from caseassignment
where objectid = 'dd820f47-2024-4857-9620-29d1520797b4'
	and enddate is null
	and activeflag = 1 ;

update caseassignment
set enddate = '2022-07-12 15:42:46',
	updatedby = 'CDM-23704',
	updatedon = now()
where objectid = 'dd820f47-2024-4857-9620-29d1520797b4'
	and enddate is null
	and activeflag = 1 ;

-- Add missing CPS AR Program Assignment
INSERT INTO cjams.personprogramarea
	(	personprogramid, personid, 
		startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, 
		datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, 
		objecttypekey, objectid, entityid, alternateid, 
		datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
VALUES
	(	gen_random_uuid(), 'd31c03a2-2096-4c79-a119-974efd6507c6',
		'2022-05-15 17:37:26', '2022-07-12 15:42:46', now(), 'CDM-23704', now(), 'CDM-23704', 1, 
		NULL, NULL, NULL, NULL, NULL, 'CPS', 'AR', 
		'servicerequest', 'dd820f47-2024-4857-9620-29d1520797b4', '221020217095', nextval('sequence_personprogramarea'::regclass), 
		NULL, NULL, NULL, NULL, 'CW'
	);

INSERT INTO cjams.personprogramarea
	(	personprogramid, personid, 
		startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, 
		datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, 
		objecttypekey, objectid, entityid, alternateid, 
		datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
VALUES
	(	gen_random_uuid(), '13548872-15dd-4319-b2ac-84be7305beaf',
		'2022-05-15 17:37:26', '2022-07-12 15:42:46', now(), 'CDM-23704', now(), 'CDM-23704', 1, 
		NULL, NULL, NULL, NULL, NULL, 'CPS', 'AR', 
		'servicerequest', 'dd820f47-2024-4857-9620-29d1520797b4', '221020217095', nextval('sequence_personprogramarea'::regclass), 
		NULL, NULL, NULL, NULL, 'CW'
	);
	
INSERT INTO cjams.personprogramarea
	(	personprogramid, personid, 
		startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, 
		datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, 
		objecttypekey, objectid, entityid, alternateid, 
		datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
VALUES
	(	gen_random_uuid(), 'd7f06298-4242-4c34-830a-d5131288d4f5',
		'2022-05-15 17:37:26', '2022-07-12 15:42:46', now(), 'CDM-23704', now(), 'CDM-23704', 1, 
		NULL, NULL, NULL, NULL, NULL, 'CPS', 'AR', 
		'servicerequest', 'dd820f47-2024-4857-9620-29d1520797b4', '221020217095', nextval('sequence_personprogramarea'::regclass), 
		NULL, NULL, NULL, NULL, 'CW'
	);	
