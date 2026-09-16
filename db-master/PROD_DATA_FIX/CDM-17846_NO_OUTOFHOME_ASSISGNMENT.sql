/* Issue Description:CDM-17846 - NO OUT OF HOME ASSISGNMENT
   Category/ Module  :  Child Removal
   Root cause: Data fix, refer getpersonprogramarea for the input.
   Pull request# for code fix: 
   Reason why no related code fix: 
 
*/

INSERT INTO cjams.personprogramarea
(personprogramid, startdate, enddate, personid, objecttypekey, objectid, endreasonkey, programkey, subprogramkey, datavalidflag, clientmergeid, ifpsatriskflag, entityid, updatedby, datatransferflag, updatedon, insertedby, insertedon, sourcetype  )
VALUES('c9b917f2-c108-4e5c-b042-43e70d1b040a'::uuid, '2021-07-30', NULL, '2add4bc9-56d9-4de7-bab6-205e2837da34'::uuid, 'servicecase', '4e50bd9a-c21a-4111-b7b8-54f5bc49a5e5', NULL, 'OOH', 'NA', NULL, NULL, NULL, '3257319', 'CDM-17846', 'C', now(), 'CDM-17846', now(), 'CW');

INSERT INTO cjams.personprogramarea
(personprogramid, startdate, enddate, personid, objecttypekey, objectid, endreasonkey, programkey, subprogramkey, datavalidflag, clientmergeid, ifpsatriskflag, entityid, updatedby, datatransferflag, updatedon, insertedby, insertedon, sourcetype  )
VALUES('d9b816f1-c208-b042-4e5c-1b040a43e70d'::uuid, '2021-07-30', NULL, '4b95196b-2941-459f-bbe4-ee83458306ea'::uuid, 'servicecase', '4e50bd9a-c21a-4111-b7b8-54f5bc49a5e5', NULL, 'OOH', 'NA', NULL, NULL, NULL, '3257319', 'CDM-17846', 'C', now(), 'CDM-17846', now(), 'CW');

 