
/*
   Issue Description: CDM-20403
   Category/ Module  : Missing OOH Program Assignment
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.personprogramarea
(personid, programkey, subprogramkey, objecttypekey, objectid, startdate, insertedby, insertedon, updatedby, updatedon, entityid, activeflag, sourcetype)
VALUES('b309a12f-b2bc-4356-be6a-67430efb0da1'::uuid, 'OOH', 'NA', 'servicecase', '652176e4-ae30-4c70-ae10-b2f1e7010580', '2021-11-25 00:00:00.000', 'CDM-20403', NOW(), 'CDM-20403', NOW(), '3241584', 1, 'CW');
