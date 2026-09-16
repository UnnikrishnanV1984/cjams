
/*
   Issue Description: CDM-17362
   Category/ Module  : Person progream insert
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


INSERT INTO personprogramarea (
personid, programkey, subprogramkey, objecttypekey, objectid, 
startdate, insertedby, insertedon, updatedby, updatedon, 
entityid, activeflag, sourcetype
) values(
'58bfd4c0-3950-4774-98b4-a23d51ea0a31', 'OOH', null, 'servicecase', 'b0d875fb-92a5-4beb-b6c3-763d79c3a63c', 
'2021-09-29 00:00:00', 'CDM-17362', now(), 'CDM-17362', now(), 
'3196463', 1, 'CW'
);