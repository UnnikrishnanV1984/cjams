INSERT INTO servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('a894226d-a33a-4a35-a804-7fc45c0252cd', '2019-12-17 12:12:43', 'Open', 'Inprogress','Case Accepted', '2019-12-17 12:12:43', 1, '82b1c827-bc1b-456e-a933-7a21a10aeb1e','2019-12-17 12:12:43','82b1c827-bc1b-456e-a933-7a21a10aeb1e','2019-12-17 12:12:43');

INSERT INTO routing(routingstatustypeid, objectid, eventcode, fromsecurityusersid, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES(16,(select servicecasedispositionid from servicecasedisposition where servicecaseid ='a894226d-a33a-4a35-a804-7fc45c0252cd' order by insertedon limit 1),'SCDR','82b1c827-bc1b-456e-a933-7a21a10aeb1e', 1, '82b1c827-bc1b-456e-a933-7a21a10aeb1e','2019-12-17 12:12:43','82b1c827-bc1b-456e-a933-7a21a10aeb1e','2019-12-17 12:12:43');
