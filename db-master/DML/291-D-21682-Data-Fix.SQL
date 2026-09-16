UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{dateoflastsafetyplan}','"2019-10-31T14:07:07.000Z"'),
updatedon =now(),
updatedby = 'CIDM-4724'
WHERE assessmentid = '3590e5e8-ca97-4f39-ae8b-c73ee2cc0cc6';