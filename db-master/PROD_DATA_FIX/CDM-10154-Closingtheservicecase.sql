-- 3302878 - dc0f2711-8726-4f01-b8b0-bb2c3cbec9fe
INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('9f092354-7fb7-47f8-b887-c0874c430163', 'dc0f2711-8726-4f01-b8b0-bb2c3cbec9fe', '2021-01-27 12:00:00', 'Closed', 'Closed', 'ICPC Case: sending state (IA) did not send children to this resource home in MD/study expired', '2021-01-27 12:00:00', 1, '1019602f-83b8-4488-a713-1ec56382edb9', now(), '1019602f-83b8-4488-a713-1ec56382edb9', now(), null, '', '', null);

SELECT * FROM cjams.routingintake('9f092354-7fb7-47f8-b887-c0874c430163','1019602f-83b8-4488-a713-1ec56382edb9','SCDR',15,'ICPC Case: sending state (IA) did not send children to this resource home in MD/study expired','c6562512-e8a4-4b7d-9d4a-5e4160ef37c8',false,false,false,'','','dc0f2711-8726-4f01-b8b0-bb2c3cbec9fe','' , 1);			

SELECT * FROM cjams.routingintake('9f092354-7fb7-47f8-b887-c0874c430163','c6562512-e8a4-4b7d-9d4a-5e4160ef37c8','SCDR',16,'Disposition Approved',null,false, false, false, 'Disposition Approved', 'Disposition Approved',null,'',1);

update cjams.servicecase set enddate = '2021-01-27 12:00:00'  where servicecaseid =  'dc0f2711-8726-4f01-b8b0-bb2c3cbec9fe';

update cjams.servicecasedisposition set statusdate = '2021-01-27 12:00:00', effectivedate =  '2021-01-27 12:00:00' where servicecasedispositionid in (select servicecasedispositionid from cjams.servicecasedisposition where servicecaseid =  'dc0f2711-8726-4f01-b8b0-bb2c3cbec9fe' and intakeserreqstatustypekey = 'Closed' order by updatedon desc limit 1);

update caseassignment set enddate = '2021-01-27 00:00:00', updatedby = 'CDM-10154', updatedon = now() where caseassignmentid = 'a463e8aa-8faf-458d-8ecb-96c742af412d';
    
-- 3304639 - 9fc189c3-f655-4ae4-b206-3d75a98bad9d
INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('9f092354-7fb7-47f8-b887-c0874c430164', '9fc189c3-f655-4ae4-b206-3d75a98bad9d', '2021-02-01 12:00:00', 'Closed', 'Closed', 'ICPC Case: children were returned to sending state (FL) in October, 2020', '2021-02-01 12:00:00', 1, '1019602f-83b8-4488-a713-1ec56382edb9', now(), '1019602f-83b8-4488-a713-1ec56382edb9', now(), null, '', '', null);

SELECT * FROM cjams.routingintake('9f092354-7fb7-47f8-b887-c0874c430164','1019602f-83b8-4488-a713-1ec56382edb9','SCDR',15,'ICPC Case: children were returned to sending state (FL) in October, 2020','c6562512-e8a4-4b7d-9d4a-5e4160ef37c8',false,false,false,'','','9fc189c3-f655-4ae4-b206-3d75a98bad9d','' , 1);			

SELECT * FROM cjams.routingintake('9f092354-7fb7-47f8-b887-c0874c430164','c6562512-e8a4-4b7d-9d4a-5e4160ef37c8','SCDR',16,'Disposition Approved',null,false, false, false, 'Disposition Approved', 'Disposition Approved',null,'',1);

update cjams.servicecase set enddate = '2021-02-01 12:00:00'  where servicecaseid =  '9fc189c3-f655-4ae4-b206-3d75a98bad9d';

update cjams.servicecasedisposition set statusdate = '2021-02-01 12:00:00', effectivedate =  '2021-02-01 12:00:00' where servicecasedispositionid in (select servicecasedispositionid from cjams.servicecasedisposition where servicecaseid =  '9fc189c3-f655-4ae4-b206-3d75a98bad9d' and intakeserreqstatustypekey = 'Closed' order by updatedon desc limit 1);

update caseassignment set enddate = '2021-02-01 00:00:00', updatedby = 'CDM-10154', updatedon = now() where caseassignmentid = 'b91f67e1-4737-4b8e-a3ad-cf11f61829e1';