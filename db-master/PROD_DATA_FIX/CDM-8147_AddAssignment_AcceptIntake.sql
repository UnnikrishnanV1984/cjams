-- CDM-8147 - Change the status of intake from review to accepted
-- Also add new assignment with the details given by user

update routing set routingstatustypeid = 2, activeflag=1, updatedby = 'CDM-8147', updatedon = now() where routingid = '182a0e88-f72c-4df8-bed3-2329189a62c1' and routingstatustypeid =1;

INSERT INTO caseassignment
(fromworkeridno, toworkeridno, insertedby, updatedby, 
insertedon, updatedon, objecttypekey, objectid,responsibilitytypekey,startdate,
fromteamid,toteamid,remarks,statustypekey,toldssid,fromldssid,assignmenttype)
VALUES('d9e27467-8d44-4607-a993-287493cdac18','58d37e58-6c91-44be-afc9-d48df3d329ae','CDM-8147','CDM-8147',
now(),now(),'servicecase','7686f846-6f48-46e2-b51e-dc8241b66ca6','family','2020-12-18 00:00:00',
null,'1cdb5062-ad47-4493-bd47-1d9b19950e07',
null,null,null,
null,'W');