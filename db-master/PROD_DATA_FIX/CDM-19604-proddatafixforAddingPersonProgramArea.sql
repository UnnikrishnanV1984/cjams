
/*
   Issue Description: CDM-19604
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
'f3a7bf48-79db-4b2e-b810-73822d27d2b7', 'OOH', null, 'servicecase', 'c8648a0b-149e-4346-be10-802468bb15e0', 
'2021-11-19 00:00:00', 'CDM-19604', now(), 'CDM-17362', now(), 
'211020145377', 1, 'CW'
);
