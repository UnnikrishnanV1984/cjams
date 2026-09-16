-- CIDM-11333: Inserting a new record set into settings table.

DELETE FROM cjams.settings
WHERE settingname = 'HP-Email-Send-Batch-Flag';

INSERT INTO cjams.settings
(
    settingname,
    settingvalue,
    activeflag,
    insertedby,
    updatedby,
    insertedon,
    updatedon,
    old_id
)
VALUES
(
    'HP-Email-Send-Batch-Flag',
    1,
    1,
    'CIDM-11333',
    'CIDM-11333',
    now(),
    now(),
    NULL
);