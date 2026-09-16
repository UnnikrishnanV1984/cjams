/*Changes to save the details from Add Note view under Contact tab,
that resulted due to addition of collateral into Involved persons*/
INSERT INTO cjams.participanttype
(participanttypekey, typedescription, displayorder, activeflag, effectivedate, old_id, insertedby, updatedby, insertedon, updatedon, objecttypekey)
VALUES('COLLATERAL', 'Collateral', 1, 0, '2018-10-19 21:21:32.884', NULL, NULL, NULL, NULL, NULL, 'CPT');