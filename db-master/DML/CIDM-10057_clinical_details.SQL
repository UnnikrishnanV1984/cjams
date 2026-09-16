--cidm-10057 update values in cjams.settings table for clinical details

Delete from cjams.settings where settingname ='medical_conditions_api' and activeflag=1;

INSERT INTO cjams.settings
(settingname, settingvalue, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('medical_conditions_api', 'https://clinicaltables.nlm.nih.gov/api/conditions/v3/search?', 1, 'CIDM-10057', 'CIDM-10057', now(), now(), NULL);