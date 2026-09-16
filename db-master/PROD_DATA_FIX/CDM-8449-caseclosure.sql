INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('e77d0715-9a54-47f0-901a-dcff32afd56e', '7e13c079-ce48-404e-a675-9aa668adc116', '2020-12-31 11:30:00', 'Closed', 'Closed', 'Case recommended for closure due to family declining services', '2020-12-31 11:30:00', 1, 'efbd089b-99af-4d65-bc0c-8855ff96b5bf', now(), 'efbd089b-99af-4d65-bc0c-8855ff96b5bf', now(), null, '', '', null);
SELECT * FROM cjams.routingintake('e77d0715-9a54-47f0-901a-dcff32afd56e','efbd089b-99af-4d65-bc0c-8855ff96b5bf','SCDR',15,'Case recommended for closure due to family declining services','72439d81-dfaa-46d0-a372-f90eb16f75fd',false,false,false,'','','7e13c079-ce48-404e-a675-9aa668adc116','' , 1);			
SELECT * FROM cjams.routingintake('e77d0715-9a54-47f0-901a-dcff32afd56e','72439d81-dfaa-46d0-a372-f90eb16f75fd','SCDR',16,'Disposition Approved',null,false, false, false, 'Disposition Approved', 'Disposition Approved',null,'',1);
update cjams.servicecase set enddate = '2020-12-31 11:30:00'  where servicecaseid =  '7e13c079-ce48-404e-a675-9aa668adc116';
update cjams.servicecasedisposition set statusdate = '2020-12-31 11:30:00', effectivedate =  '2020-12-31 11:30:00' where servicecasedispositionid in (select servicecasedispositionid from cjams.servicecasedisposition where servicecaseid =  '7e13c079-ce48-404e-a675-9aa668adc116' and intakeserreqstatustypekey = 'Closed' order by updatedon desc limit 1);



INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('098ea49d-7df2-4e6d-95aa-5d30e2b29b57', '000d9ad7-4e7a-44a9-8e89-dc6a530e199e', '2020-10-05 11:30:00', 'Closed', 'Closed', 'Case recommended for closure due to family declining services', '2020-10-05 11:30:00', 1, 'efbd089b-99af-4d65-bc0c-8855ff96b5bf', now(), 'efbd089b-99af-4d65-bc0c-8855ff96b5bf', now(), null, '', '', null);
SELECT * FROM cjams.routingintake('098ea49d-7df2-4e6d-95aa-5d30e2b29b57','efbd089b-99af-4d65-bc0c-8855ff96b5bf','SCDR',15,'Case recommended for closure due to family declining services','72439d81-dfaa-46d0-a372-f90eb16f75fd',false,false,false,'','','000d9ad7-4e7a-44a9-8e89-dc6a530e199e','' , 1);			
SELECT * FROM cjams.routingintake('098ea49d-7df2-4e6d-95aa-5d30e2b29b57','72439d81-dfaa-46d0-a372-f90eb16f75fd','SCDR',16,'Disposition Approved',null,false, false, false, 'Disposition Approved', 'Disposition Approved',null,'',1);
update cjams.servicecase set enddate = '2020-10-05 11:30:00'  where servicecaseid =  '000d9ad7-4e7a-44a9-8e89-dc6a530e199e';
update cjams.servicecasedisposition set statusdate = '2020-10-05 11:30:00', effectivedate =  '2020-10-05 11:30:00' where servicecasedispositionid in (select servicecasedispositionid from cjams.servicecasedisposition where servicecaseid =  '000d9ad7-4e7a-44a9-8e89-dc6a530e199e' and intakeserreqstatustypekey = 'Closed' order by updatedon desc limit 1);

