/*
   Issue Description: CDM-23913
   Category/ Module  : Court
   Root cause: For some court hearing records, client details are not available. Adding the hearingclientdetails from the petition details.

   Reason why no related code fix: 
   Need to do only data fix
*/

DELETE FROM cjams.hearingclients 
WHERE courthearingid = 'b95a135c-e5ad-45f1-980e-a743ce3042c9' AND personid = 'dd99f006-f8ee-4c9d-81de-83e19f8d024c';

INSERT INTO cjams.hearingclients (courthearingid, updatedby, updatedon, insertedby, insertedon, activeflag, personid, otherclientflag) 
VALUES('b95a135c-e5ad-45f1-980e-a743ce3042c9', 'CDM-23913', now(), 'CDM-23913', now(), 1, 'dd99f006-f8ee-4c9d-81de-83e19f8d024c', 0);

DELETE FROM cjams.hearingclients 
WHERE courthearingid = 'ee5f9945-9d43-4e80-83e4-0ca9aae7a777' AND personid = 'dd99f006-f8ee-4c9d-81de-83e19f8d024c';

INSERT INTO cjams.hearingclients (courthearingid, updatedby, updatedon, insertedby, insertedon, activeflag, personid, otherclientflag) 
VALUES('ee5f9945-9d43-4e80-83e4-0ca9aae7a777', 'CDM-23913', now(), 'CDM-23913', now(), 1, 'dd99f006-f8ee-4c9d-81de-83e19f8d024c', 0);

DELETE FROM cjams.hearingclients 
WHERE courthearingid = '8dbfdae8-4950-475b-aacb-3c288a89ebb5' AND personid = '573e716c-4666-4578-bad1-d1876d014b7b';

INSERT INTO cjams.hearingclients (courthearingid, updatedby, updatedon, insertedby, insertedon, activeflag, personid, otherclientflag) 
VALUES('8dbfdae8-4950-475b-aacb-3c288a89ebb5', 'CDM-23913', now(), 'CDM-23913', now(), 1, '573e716c-4666-4578-bad1-d1876d014b7b', 0);

DELETE FROM cjams.hearingclients 
WHERE courthearingid = '8dbfdae8-4950-475b-aacb-3c288a89ebb5' AND personid = '7a11b44f-f423-4808-b130-9082c474ac01';

INSERT INTO cjams.hearingclients (courthearingid, updatedby, updatedon, insertedby, insertedon, activeflag, personid, otherclientflag) 
VALUES('8dbfdae8-4950-475b-aacb-3c288a89ebb5', 'CDM-23913', now(), 'CDM-23913', now(), 1, '7a11b44f-f423-4808-b130-9082c474ac01', 1);
