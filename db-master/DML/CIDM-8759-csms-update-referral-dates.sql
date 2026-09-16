DELETE FROM cjams.settings
WHERE settingname = 'csms_updt_startdt';

INSERT INTO cjams.settings
(settingname, settingvalue, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('csms_updt_startdt', '2024-12-27 00:00:00.000', 1, NULL, 'CIDM-8759', NULL, now(), NULL);
