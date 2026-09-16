
--CDM-352 assessment save is failed due to comments character length

ALTER TABLE assessmentsubmission ALTER COLUMN datavalue TYPE text;
ALTER TABLE assessmentcomments ALTER COLUMN comments TYPE text;