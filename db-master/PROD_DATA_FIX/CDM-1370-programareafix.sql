delete from personprogramarea where personid='fbf777d3-748d-48e8-895c-77bf40689b27' and entityid=20200490976 and programkey='OOH' and startdate::date = '2020-04-17';

INSERT INTO cjams.personprogramarea
( personid, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, objecttypekey, objectid, entityid, datatransferflag, datasentdate, etl_userid, etl_load_date)
VALUES('fbf777d3-748d-48e8-895c-77bf40689b27', '2020-04-17 00:00:00.000', '2020-05-15 00:00:00.000', now(), 'CDM-1370', now(), 'CDM-1370', 1, NULL, NULL, '3396', 0, NULL, 'OOH', NULL, 'servicecase', 'b044a048-4f0f-450d-ad55-c570570aec3e', '20200490976', 'C', now(), NULL, NULL);
