UPDATE cjams.assessment
SET submissiondata= submissiondata - 'dateoflastsafetyplan' || '{"dateoflastsafetyplan" : null}'
WHERE assessmentid='fe6685bc-97b5-4ef0-b05b-f73a09b330d5';

UPDATE cjams.assessment
SET submissiondata= submissiondata - 'dateoflastsafetyplan' || '{"dateoflastsafetyplan" : null}'
WHERE assessmentid='3590e5e8-ca97-4f39-ae8b-c73ee2cc0cc6';

 UPDATE cjams.assessmentsubmission
SET  datavalue=NULL
WHERE assessmentsubmissionid='a5f92e0a-5a0e-4d12-89da-c2a516ada6fb';
