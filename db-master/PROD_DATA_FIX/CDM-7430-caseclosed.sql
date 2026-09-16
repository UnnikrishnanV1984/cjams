INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('23773764-d3fc-4ab9-bf88-8cec535c8ca1', 'f967b749-3b71-41bb-9bf2-3c91afb7a934', '2020-11-08 12:00:00', 'Closed', 'Closed', 'Case Closed', now(), 1, '038f50d3-1dc6-4c47-ab32-63952fdb0e5b', now(), '038f50d3-1dc6-4c47-ab32-63952fdb0e5b', now(), null, '', '', null);
SELECT * FROM cjams.routingintake('23773764-d3fc-4ab9-bf88-8cec535c8ca1','038f50d3-1dc6-4c47-ab32-63952fdb0e5b','SCDR',15,'Case Closed','fa484839-8478-4808-9412-261477e894e7',false,false,false,'','','f967b749-3b71-41bb-9bf2-3c91afb7a934','' , 1);			
SELECT * FROM cjams.routingintake('23773764-d3fc-4ab9-bf88-8cec535c8ca1','fa484839-8478-4808-9412-261477e894e7','SCDR',16,'Disposition Approved',null,false, false, false, 'Disposition Approved', 'Disposition Approved',null,'',1);
update cjams.servicecase set enddate = '2020-11-08 12:00:00'  where servicecaseid =  'f967b749-3b71-41bb-9bf2-3c91afb7a934';
update cjams.servicecasedisposition set statusdate = '2020-11-08 12:00:00' where servicecasedispositionid in (select servicecasedispositionid from cjams.servicecasedisposition where servicecaseid =  'f967b749-3b71-41bb-9bf2-3c91afb7a934' and intakeserreqstatustypekey = 'Closed' order by updatedon desc limit 1);


