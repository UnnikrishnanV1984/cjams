-- CDM-14615
update intakeservreqchildremoval 
set exitdate = '2020-12-18 14:30:00', 
	removalexitreason = 'RUF', 
	updatedby = 'CDM-14615', 
	updatedon = now() 
where intakeservreqchildremovalid = '43cf8530-3675-41c6-94d9-feaec6315bce';

UPDATE personprogramarea 
SET updatedby = 'CDM-14615', 
	updatedon = now(), 
	enddate = '2020-12-18 14:30:00'
WHERE personprogramid = 'ef7abff7-d708-4f86-b46a-ce6e7272dedb';

INSERT INTO personprogramarea (
personid, programkey, subprogramkey, objecttypekey, objectid, 
startdate, insertedby, insertedon, updatedby, updatedon, 
entityid, activeflag, sourcetype
) values(
'605e0f2e-c24c-47d7-a389-e9526cb4ded8', 'OOH', null, 'servicecase', 'f94d811a-06d7-4684-80f7-36321018a0f1', 
'2021-02-04 00:00:00', 'CDM-14615', now(), 'CDM-14615', now(), 
'2020031404089', 1, 'CW'
);