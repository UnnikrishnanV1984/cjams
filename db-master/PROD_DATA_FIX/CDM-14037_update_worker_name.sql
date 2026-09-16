-- CDM-14037
-- Update case worker name in an assessment 
UPDATE assessment 
SET updatedby = 'CDM-14037', 
    updatedon = now(), 
    submissiondata = REPLACE (submissiondata::TEXT, '"workername1": "Mattie R. Meehan"', '"workername1": "Abigail Ritchie"')::jsonb 
WHERE assessmentid =  '45174bf1-218b-432f-8b34-a50c5d09c87e';