UPDATE assessment 
SET updatedby = 'CDM-13414', updatedon = now(), submissiondata = REPLACE (submissiondata::TEXT, '"workername": "JusVenus Hinton"', '"workername": "Nikki Klock"')::jsonb 
WHERE assessmentid =  '6a6e3b91-8843-4169-a1ec-13a554d091d8';