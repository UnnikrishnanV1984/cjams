/*
 * CIDM-8701 - CPS Program Assignment is missing for client in CPS case - Reported in LJ Meeting
 * Intake : I241011954129
 * CPS Case : 241021799585
 * 
 */

-- SELECT intakeserviceid, actiontype, insertedon, servicerequestnumber FROM  intakeservicerequest WHERE intakenumber = 'I241011954129'; -- INTO intake_service_req_id, v_actiontype, l_inserteddate, v_servicerequestno
-- SELECT updatedon, routingstatustypeid, activeflag, eventcode  FROM routing   WHERE  --INTO l_accepteddate, routingstatustypeid = 2 AND activeflag =1 AND eventcode ='INTR' AND 
-- objectid = 'I241011954129'; 

--select * from personprogramarea where objectid ='447f5eac-6b4e-4c0e-b11c-eaeeeeea3713';

DELETE FROM cjams.personprogramarea
WHERE personid in ('27978058-1d7c-4fdf-b3ff-0568a8bec80e', 'b2dcea36-a20b-44b4-b6d2-ac02fe193f36') and objectid='447f5eac-6b4e-4c0e-b11c-eaeeeeea3713' and insertedby='CIDM-8701';

INSERT INTO cjams.personprogramarea
(personid, programkey,subprogramkey,objecttypekey,objectid,startdate,enddate,insertedby,updatedby,entityid, datatransferflag, sourcetype) 
VALUES('27978058-1d7c-4fdf-b3ff-0568a8bec80e','CPS','IR','servicerequest','447f5eac-6b4e-4c0e-b11c-eaeeeeea3713',COALESCE('2024-01-12 16:43:24.310','2024-01-12 16:43:43.949')::date,'2024-03-06 16:06:00.000'::date,'CIDM-8701','CIDM-8701','241021799585','A', 'CW');

INSERT INTO cjams.personprogramarea
(personid, programkey,subprogramkey,objecttypekey,objectid,startdate,enddate,insertedby,updatedby,entityid, datatransferflag, sourcetype) 
VALUES('b2dcea36-a20b-44b4-b6d2-ac02fe193f36','CPS','IR','servicerequest','447f5eac-6b4e-4c0e-b11c-eaeeeeea3713',COALESCE('2024-01-12 16:43:24.310','2024-01-12 16:43:43.949')::date,'2024-03-06 16:06:00.000'::date,'CIDM-8701','CIDM-8701','241021799585','A', 'CW');
