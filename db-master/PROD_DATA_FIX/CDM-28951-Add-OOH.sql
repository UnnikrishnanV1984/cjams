/*
   Issue Description: CDM-28951
   Category/ Module  :  Program Assignment
   Root cause: user wants to add OOH with date
   Pull request# for data fix:  8081
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/
INSERT INTO personprogramarea (
personid, programkey, subprogramkey, objecttypekey, objectid, 
startdate, insertedby, insertedon, updatedby, updatedon, 
entityid, activeflag, sourcetype
) values(
'f6de5b72-977b-4baf-a1e6-88a63bd09fa2', 'OOH', null, 'servicecase', '029082c3-b283-4d25-ace4-cb18ea2c060a', 
'2022-05-04 00:00:00', 'CDM-28951', now(), 'CDM-28951', now(), 
'221030016265', 1, 'CW'
);