--D-24095 safec-ohp showing incorrect client id
UPDATE assessmentsubmission
SET datavalue = '3554434'
WHERE assessmentsubmissionid IN 
('aae51a15-217c-4f31-8148-cd2d7d02c25f',
'9bfa1bd8-6ba6-4563-84d1-6a972c0d38b0');

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{clientid}','"3554434"')
WHERE assessmentid = 'd453565c-eea5-4d49-8074-58c1aaa377e9';