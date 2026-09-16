DELETE FROM cjams.settings
WHERE settingname = 'KRD_enddate';

DELETE FROM cjams.settings
WHERE settingname = 'KRD_startdate';

INSERT INTO cjams.settings
(settingname, settingvalue, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('KRD_enddate', '2024-12-12 23:59:00.000', 1, NULL, 'CIDM-9688', now(), now(), NULL);

INSERT INTO cjams.settings
(settingname, settingvalue, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('KRD_startdate', '2024-12-12 00:00:00.000', 1, NULL, 'CIDM-9688', now(), now(), NULL);