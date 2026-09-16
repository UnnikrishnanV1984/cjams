/*
   Issue Description: CDM-19379
   Category/ Module  : Program assignments incorrect
   Root cause: user wants to change dates
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
 
 
--Karson
select * from personprogramarea where personid = '356700fb-d890-4cee-8893-075f00f372d0';

update personprogramarea
set startdate =  '2021-11-17', activeflag = 1,  updatedby='CDM-19379', updatedon=now() 
where personprogramid ='1cda4311-45c2-437e-9193-8d86ded26b3a' and personid = '356700fb-d890-4cee-8893-075f00f372d0';

update personprogramarea
set startdate =  '2021-11-17', activeflag = 0, updatedby='CDM-19379', updatedon=now() 
where personprogramid ='3b3a531a-dd59-4794-86b2-ee138f7e3cd4' and personid = '356700fb-d890-4cee-8893-075f00f372d0';

--Lyric
select * from personprogramarea where personid = '07bd6c6c-55c2-4d19-9481-19fb6ced2721';

update personprogramarea
set startdate =  '2021-11-17', activeflag = 1,  updatedby='CDM-19379', updatedon=now() 
where personprogramid ='9f65b1bd-6d0d-47d5-8224-84ccba3739a7' and personid = '07bd6c6c-55c2-4d19-9481-19fb6ced2721';

update personprogramarea
set startdate =  '2021-11-17', activeflag = 0, updatedby='CDM-19379', updatedon=now() 
where personprogramid ='6db58a39-54e3-44af-8d37-21f38bd11bb4' and personid = '07bd6c6c-55c2-4d19-9481-19fb6ced2721';

--Brooklynne  
select * from personprogramarea where personid = '8bc9e958-595b-49b9-946c-3f539b7b94f8';

INSERT INTO cjams.personprogramarea
(personprogramid, personid, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, objecttypekey, objectid, entityid, alternateid, datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
VALUES('1ffbdafc-d5cc-44d6-a366-f531f12e18ef', '8bc9e958-595b-49b9-946c-3f539b7b94f8', '2021-11-17 00:00:00.000', NULL, now(), 'CDM-19379', now(), 'CDM-19379', 1, NULL, NULL, NULL, NULL, NULL, 'OOH', '', 'servicecase', 'f3de8765-6ee9-4b2d-89cb-e802646195eb', '3229197', 4021998, NULL, NULL, NULL, NULL, 'CW');

