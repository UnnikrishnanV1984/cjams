/*
   Issue Description: CDM-28702
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO personprogramarea (
personid, programkey, subprogramkey, objecttypekey, objectid, 
startdate, insertedby, insertedon, updatedby, updatedon, 
entityid, activeflag, sourcetype
) values(
'f6de5b72-977b-4baf-a1e6-88a63bd09fa2', 'OOH', 'NA', 'servicecase', '029082c3-b283-4d25-ace4-cb18ea2c060a',
'2022-05-04 00:00:00', 'CDM-28702', now(), '45391f16-58de-4b24-bd7e-12cdc4ff4335', now(), 
'221030016265', 1, 'CW'
);