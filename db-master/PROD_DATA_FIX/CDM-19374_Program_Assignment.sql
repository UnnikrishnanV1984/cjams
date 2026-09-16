/*
   Issue Description: CDM-19374
   Category/ Module  : Program Assignment
   Root cause: user wants to remove person other
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select * from personprogramarea where personid = '4e8e8f83-4ea0-474a-a44d-ec0f2343ba77';
--INSERT INTO cjams.personprogramarea
--(personprogramid, personid, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, objecttypekey, objectid, entityid, alternateid, datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
--VALUES('855c7567-a562-420d-aca8-f6bc8fadf1cb'::uuid, '4e8e8f83-4ea0-474a-a44d-ec0f2343ba77'::uuid, '2018-11-27 00:00:00.000', '2021-02-15 00:00:00.000', '2019-01-03 01:13:38.000', 'AWI922403', '2021-03-05 15:12:53.200', '3b04c95a-113b-4026-9180-e9aa05e08b13', 1, NULL, 0, NULL, NULL, '2558149', 'OOH', NULL, 'servicecase', '536c861d-38a3-4939-b2bb-181243d46ed5', '3285018', 2558149, 'C', '2021-03-05 15:12:53.200', 'dm_update', '2020-05-16', 'CW');


update personprogramarea
set enddate =  null, updatedby='CDM-19374', updatedon=now() 
where personprogramid = '855c7567-a562-420d-aca8-f6bc8fadf1cb' and personid = '4e8e8f83-4ea0-474a-a44d-ec0f2343ba77';