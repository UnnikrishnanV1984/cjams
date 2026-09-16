--cidm-9541 update values in cjams.settings table for email

delete from cjams.settings where settingname ='psychotropic_cjams' and activeflag=1;

INSERT INTO cjams.settings
(settingname, settingvalue, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('psychotropic_cjams', 'cw.cjams.mdthink.maryland.gov', 1, 'CIDM-9541', 'CIDM-9541', now(), now(), NULL);
