-- CDM-10889 - Placements Need Fixing - Payment issue
/*
-- Issue Description: 
   Datafix to re-open the Service Case as well as the client's removal, so they can create the missing placement.
   
   Case ID: 3229160 - 116ffac8-cd62-471a-ae49-d1397d5b9c5b
   Client ID: 3813424 (ISAIAH GARRETT) - 0960ccdd-4b35-4dd4-babc-d894f55fa146

   
-- Category/ Module: Placement (Case Management) 
-- Root cause: User error, case was closed prior to placement entry (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Living Arrengment End date
select startdatetime, enddatetime, placementtypekey, alternateid, updatedby, updatedon 
	from cjams.placement  
where personid = '0960ccdd-4b35-4dd4-babc-d894f55fa146'
	and placementid = 'bf8cff13-6865-4267-9b5c-357d4ff86f5d'
	and activeflag  = 1 ;

update cjams.placement 
	set enddatetime = '2020-07-26 00:00:00',
		updatedon = now(), 
		updatedby = 'CDM-10889'
where personid = '0960ccdd-4b35-4dd4-babc-d894f55fa146'
	and placementid = 'bf8cff13-6865-4267-9b5c-357d4ff86f5d'
	and activeflag  = 1 ;


-- Update Placement End date (Voided Placements)
select startdatetime, enddatetime, endtime, placementtypekey, alternateid, updatedby, updatedon 
	from cjams.placement 
where personid ='0960ccdd-4b35-4dd4-babc-d894f55fa146'
	and placementid  = '5e3162f4-13fa-41c5-945e-28833e3d4058'
	and activeflag  = 1 ;

update cjams.placement 
	set enddatetime = '2020-11-09 15:54:11',
		updatedon = now(), 
		updatedby = 'CDM-10889'
where personid ='0960ccdd-4b35-4dd4-babc-d894f55fa146'
	and placementid  = '5e3162f4-13fa-41c5-945e-28833e3d4058'
	and activeflag  = 1 ;


-- Re-open the Service case
update servicecase 
set enddate = null, 
	statustypekey = 'pending', 
	dispositioncode = 'open', 
	updatedon = now(), 
	updatedby = 'CDM-10889'
where servicecaseid = '116ffac8-cd62-471a-ae49-d1397d5b9c5b';

insert into cjams.servicecasedisposition
(	servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, 
	dispositioncode, "comments", effectivedate, activeflag, 
	insertedby, insertedon, updatedby, updatedon, expirationdate, 
	old_id, etl_userid, etl_load_date
)
values
(	gen_random_uuid(), '116ffac8-cd62-471a-ae49-d1397d5b9c5b', now(), 'Reopen', 
	'Inprogress', 'Reopening a Closed Case for missing placement entry', now(), 1, 
	'CDM-10889', now(), 'CDM-10889', now(), NULL, 
	'3229160', null, null
);

insert into cjams.caseassignment
(	caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, 
	fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, 
	effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, 
	foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, 
	updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, 
	startdate, enddate, fromteamid, toteamid, remarks, 
	statustypekey, fromldssid, toldssid, assignmenttype, fk_id, 
	assigndate, isrestricted, assigndescription, summary, isnew, 
	expungementflag, entityopendate, etl_userid, etl_load_date
)
values
(	gen_random_uuid(), '116ffac8-cd62-471a-ae49-d1397d5b9c5b', NULL, '2f9b37aa-865e-4a29-97ac-bb52ca1244bb', '6008620', 
	NULL, '2b437a57-1840-4d24-81b4-88f9a3e49e53', '6028432', NULL, NULL, 
	NULL, NULL, NULL, NULL, '3229160', 
	NULL, NULL, 'CDM-10889', 'CDM-10889', now(), 
	now(), 'servicecase', '116ffac8-cd62-471a-ae49-d1397d5b9c5b', 'family', 1, 
	now(), null, 'd69c0a42-a067-4765-be54-722c08ae7c5d', '5de8554e-67e6-4940-b5f6-1c1827dbd9c9', NULL, 
	NULL, '34457960-811a-4d35-a416-b8941d6974cc', '34457960-811a-4d35-a416-b8941d6974cc', 'W', '6001777', 
	NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL
);


-- Re-open Removal

-- Update Removal
select removalid, removaldate, exitdate, returndate, returntime, returntransts, updatedby, updatedon
	from cjams.intakeservreqchildremoval 
where removalid = 200160
	and activeflag = 1
	and exitdate is not null ;


update cjams.intakeservreqchildremoval 
set exitdate = NULL,
	returndate = NULL,
	returntime = NULL,
	returntransts = NULL,
	updatedby = 'CDM-10889',
	updatedon = now()
where removalid = 200160
	and activeflag = 1
	and exitdate is not null ;

-- Re-open OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '77e20d8e-b0b6-4009-bd38-15cad222bc89'
	and activeflag = 1 ;


update cjams.personprogramarea 
	set enddate = null, 
		updatedby = 'CDM-10889',
		updatedon = now()
where personprogramid = '77e20d8e-b0b6-4009-bd38-15cad222bc89'
	and activeflag = 1 ;


-- Re-open Eligibility
-- Not required already open


