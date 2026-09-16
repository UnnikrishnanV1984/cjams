-- CIDM-10187 AFCARS Data Improvement - <removal_1993 & 2020>& E69 Removal date
-- Master Data to Classify removals under <removal_1993> 
-- Criteria removal end date is before October 1, 2022.

Delete from cjams.settings where settingname = 'afcars_1993_removal';

INSERT INTO cjams.settings
	(settingname, settingvalue, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES
	('afcars_1993_removal', '2022-10-01', 1, 'CIDM-10187', 'CIDM-10187', now(), now(), NULL);
