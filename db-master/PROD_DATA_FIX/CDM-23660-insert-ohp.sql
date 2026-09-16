/*
-- CDM-23660 -- 

-- Issue Description: 
 Unable to create OHP
  
-- Customer Email ID: kathleen.jackson@maryland.gov

-- Root cause: Data fix to insert the OHP
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

INSERT INTO cjams.personprogramarea
(personid, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, objecttypekey, objectid, entityid, alternateid, datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
VALUES('dc4c727a-a9f6-40cd-99f3-65f4d9275669'::uuid, '2022-06-07 00:00:00.000', NULL, now(), 'CDM-23660', now(), 'CDM-23660', 1, NULL, NULL, NULL, NULL, NULL, 'OOH', 'NA', 'servicecase', 'e4443037-a6b5-40f1-bedb-8ead65d3fe52', '3278869', 4105122, 'C', '2022-06-08 16:53:51.145', NULL, NULL, 'CW');