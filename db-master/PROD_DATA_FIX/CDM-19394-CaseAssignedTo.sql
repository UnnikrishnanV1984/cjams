/*
   Issue Description: CDM-19394
   Category/ Module  : Case added to be assigned tab
   Root cause: user wants to assign case so added in tab 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


INSERT INTO cjams.caseassignment
(eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, 
toworkeridno, insertedby, updatedby, insertedon, updatedon, objecttypekey, 
objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, assigndate)
VALUES('88c3ebe2-978c-49f3-8d21-4f74473fb532'::uuid, NULL, 'e2842f9c-7cd1-4570-ae01-dc431596e4e9', NULL, NULL, 
'e2842f9c-7cd1-4570-ae01-dc431596e4e9', 'CDM-19394', 'CDM-19394', now(), now(), 'servicecase', 
'bcdae2c3-b9ee-402c-b2a3-278bdabb9fde'::uuid, 'administrative', 1, '2020-12-28 00:00:00.000', null, '3ab65420-fab6-4064-a3b2-c019a76171e4'::uuid, '3ab65420-fab6-4064-a3b2-c019a76171e4'::uuid, '<p>Admin Rights given for TPO filed</p>', 'ASSGN', '2021-12-28 00:00:00.000');