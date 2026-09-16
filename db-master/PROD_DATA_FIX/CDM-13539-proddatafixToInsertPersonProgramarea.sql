/*
   Issue Description: CDM-13539
   Category/ Module  : Prod data fix to add CPS Program Assignment
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

INSERT INTO cjams.personprogramarea
(personid, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, objecttypekey, objectid, entityid, alternateid, datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
VALUES('4d97e1f1-7ad8-40c5-a6c3-5a3289c98061'::uuid, '2021-05-12 00:00:00.000', '2021-06-02 16:13:39.453', '2021-05-12 17:04:39.802', 'CDM-13539', '2021-06-02 16:13:42.298', 'e2842f9c-7cd1-4570-ae01-dc431596e4e9', 1, NULL, NULL, NULL, NULL, NULL, 'CPS', 'AR', 'servicerequest', 'c6b6f364-caba-44d5-b449-2e2feb660d39', '202101320109141', 3814415, 'C', '2021-06-02 16:13:42.298', NULL, NULL, 'CW');
 