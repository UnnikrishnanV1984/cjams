
/*
   Issue Description: CDM-15080
   Category/ Module  :  Adding Missing Person program area
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
'54d7e593-cc70-4362-8965-4af1a7205f55', 'OOH', null, 'servicecase', '6aacdc36-faf6-4833-bc87-484f161563fe', 
'2021-05-12 00:00:00', 'CDM-15080', now(), 'CDM-15080', now(), 
'3260139', 1, 'CW'
);