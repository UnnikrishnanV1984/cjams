-- B-210238 Agreement Overlap Dates for Placement

Delete from cjams.settings where settingname = 'agreement_overlap_date';

INSERT INTO cjams.settings
	(settingname, settingvalue, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES
	('agreement_overlap_date', '2022-12-31 23:59:00.000', 1, 'B-210238', 'B-210238', now(), now(), NULL);