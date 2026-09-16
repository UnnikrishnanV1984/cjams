UPDATE servicecase SET statustypekey ='OPEN', dispositioncode = NULL, updatedby = 'CDM-1582',updatedon = now(), enddate = null, startdate ='2020-05-22 10:30:58' WHERE servicecaseid = '1fbc81d2-44fa-4caf-8e93-99d5e7d7453f';

INSERT INTO servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('1fbc81d2-44fa-4caf-8e93-99d5e7d7453f', '2020-05-22 10:30:58', 'Open', 'Inprogress','Case Reopened', '2020-05-22 10:30:58', 1, 'CDM-1582',now(),'CDM-1582',now());