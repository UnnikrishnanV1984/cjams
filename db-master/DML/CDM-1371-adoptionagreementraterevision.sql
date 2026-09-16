UPDATE cjams.adoptionagreementraterevision
SET activeflag=0, updatedby='CDM-1371', updatedon=now()
WHERE adoptionagreementraterevisionid='5a386e7f-f4a4-41bd-8041-57234630e836';

UPDATE cjams.adoptionagreementraterevision
SET updatedon=now(), updatedby='CDM-1371', approvalstatustypekey = '3047', status = 'Approved'
WHERE adoptionagreementraterevisionid='ce1e6141-238e-4ade-9894-19a4a935eaf0';

INSERT INTO cjams.adoptionagreementrate
(adoptionagreementid, startdate, enddate, provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, parent1actorid, parent2actorid, childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, specialneedtypekey, specialneedremarks, transactiondate, status)
VALUES( 'fdde659d-593e-4a8e-864d-bd6611a247f3', '2020-05-27 04:00:00', '2021-05-26 08:00:00', 5093121, 407, NULL, now(), 1, NULL, NULL, 'Close relationship and bond established', NULL, 1, now(), 'CDM-1371', now(), 'CDM-1371', now(), NULL, 'ADDA', NULL, '2020-05-27 00:00:00', 'Approved');

