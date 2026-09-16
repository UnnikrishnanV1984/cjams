DELETE FROM cjams.settings
WHERE settingname='psychotrophic_coordinators_group_email';

INSERT INTO cjams.settings
(settingname, settingvalue, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('psychotrophic_coordinators_group_email', 'manasa.kasula@maryland.gov', 1, NULL, 'CIDM-10188', now(), now(), NULL);
