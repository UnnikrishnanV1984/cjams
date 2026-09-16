
/*
   Issue Description: CDM-20654
   Category/ Module  : Adding User access to Restricted Items
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.restricteditems
(objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date)
VALUES('SERVICE', 'ee21864b-a173-4a82-a9d0-9f6bd5b7fed6', 'a26dcd1d-a287-43bb-afc9-da75f966f69b', NULL, false, false, false, 'CDM-20654', 'CDM-20654', NOW(), NOW(), 1, NULL, NULL);


INSERT INTO cjams.restricteditems
(objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date)
VALUES('SERVICE', 'ee21864b-a173-4a82-a9d0-9f6bd5b7fed6', 'f156b6d0-67af-404f-bf79-d4fbd737716c', NULL, false, false, false, 'CDM-20654', 'CDM-20654', NOW(), NOW(), 1, NULL, NULL);

INSERT INTO cjams.caseassignment
( fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype)
VALUES( NULL, NULL, 'a26dcd1d-a287-43bb-afc9-da75f966f69b', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CDM-20654', 'CDM-20654', NOW(), NOW(), 'servicecase', 'ee21864b-a173-4a82-a9d0-9f6bd5b7fed6'::uuid, 'administrative', 1, NOW(), NULL, 'a4bf63ee-9314-458b-95d9-0c7095db11a4'::uuid, 'a4bf63ee-9314-458b-95d9-0c7095db11a4'::uuid, '', 'ASSGN', 'b0ca6422-8241-4d86-bfef-51c7225de2fc'::uuid, 'b0ca6422-8241-4d86-bfef-51c7225de2fc'::uuid, 'W', NULL, NOW(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.caseassignment
( fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype)
VALUES( NULL, NULL, 'f156b6d0-67af-404f-bf79-d4fbd737716c', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CDM-20654', 'CDM-20654', NOW(), NOW(), 'servicecase', 'ee21864b-a173-4a82-a9d0-9f6bd5b7fed6'::uuid, 'administrative', 1, NOW(), NULL, 'a4bf63ee-9314-458b-95d9-0c7095db11a4'::uuid, 'a4bf63ee-9314-458b-95d9-0c7095db11a4'::uuid, '', 'ASSGN', 'b0ca6422-8241-4d86-bfef-51c7225de2fc'::uuid, 'b0ca6422-8241-4d86-bfef-51c7225de2fc'::uuid, 'W', NULL, NOW(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
