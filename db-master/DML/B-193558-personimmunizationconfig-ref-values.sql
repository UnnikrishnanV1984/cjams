-- B-193558 Update the typo errors of value_text of existing values
-- These vaccines are misspelled, so updated the correct value_text
UPDATE cjams.personimmunizationconfig 
SET value_text = 'Haemophilus influenzae type b',
    updatedby = 'B-193558',
    updatedon = now()
WHERE value_text = 'Haernophilus influenzae type b';

UPDATE cjams.personimmunizationconfig
SET value_text = btrim(value_text),
    updatedby = 'B-193558',
    updatedon = now()
WHERE value_text <> btrim(value_text) AND activeflag = 1;