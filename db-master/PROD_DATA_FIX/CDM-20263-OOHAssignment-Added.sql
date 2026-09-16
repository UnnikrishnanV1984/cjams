/*
   Issue Description: CDM-20263
   Category/ Module  : OOH Assignment
   Root cause: user wants add OOH assignment with end date
   Pull request# for code fix: 4785
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
	
INSERT INTO cjams.personprogramarea
    (personid, startdate, enddate, insertedon, 
    insertedby, updatedon, updatedby, activeflag, datavalidflag, clientmergeid, 
    endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, objecttypekey, objectid, entityid, alternateid, datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
VALUES('ac52f1f5-0939-4f98-9c80-62dc5ea93459'::uuid, '2021-02-05 00:00:00.000', '2021-05-12 00:00:00.000', now(),
'CDM-20263', now(), 'CDM-20263', 1, NULL, NULL, 
NULL, 0, NULL, 'OOH', NULL, 'servicecase', '085e9ffb-374e-4724-b96a-d7ea0d09655b', '202104205956', null, 'C', NULL, NULL, NULL, 'CW');