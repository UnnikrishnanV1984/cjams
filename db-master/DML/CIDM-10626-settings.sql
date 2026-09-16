--cidm-9541 update values in cjams.settings table for email

delete from cjams.settings where settingname ='ivealertsnotificationdate' and activeflag=1;

INSERT INTO cjams.settings
(settingname, settingvalue, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('ivealertsnotificationdate', '2025-10-16', 1, 'CIDM-10626', 'CIDM-10626', now(), now(), NULL);