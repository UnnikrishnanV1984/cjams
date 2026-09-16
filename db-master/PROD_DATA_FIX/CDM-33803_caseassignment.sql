/*
   Issue Description:CDM-33803
   Category/ Module  : Intake Approval case assignment 
   Root cause: After intake approval when it reopens a existing case then case assignment is not happening
   Fix Provided: Did data fix to assign the case to approved supervisor with adminstartive type.

*/

INSERT INTO cjams.caseassignment
(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype)
VALUES('abe58d96-d2ec-40b3-b2f1-981baab01af9', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', 'CDM-33803', 'CDM-33803', now(), now(), 'servicecase', '1c98dd74-fcae-440b-88a3-af8b413868e8'::uuid, 'administrative', 1, '2023-08-23 11:17:00.000', null, '96e4a285-8f90-47a8-a589-419d5bdd291b'::uuid, '96e4a285-8f90-47a8-a589-419d5bdd291b'::uuid, NULL, NULL, '817e0751-1fa8-4c31-8233-8fffd6426235'::uuid, '817e0751-1fa8-4c31-8233-8fffd6426235'::uuid, 'W');
