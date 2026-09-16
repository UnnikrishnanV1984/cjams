-- B-125253 CW - AFCARS 2.0 - Adoption Guardianship Story - CIDM-5099

/*
Adoption Guardianship Story

Adding new json columns
*/
-- intercountry adoption to store Yes/No values
ALTER TABLE cjams.person add column if not exists intercountryadoption int;
-- prior legal guardianship before current OOH placement? 
-- No (0), Yes(1), Abandoned(2)
ALTER TABLE cjams.person add column if not exists priorlegalguardianship int;
-- prior legal guardianship date if it was Yes
ALTER TABLE cjams.person add column if not exists preplacementguardianshipdate timestamp;

-- Comments for cjams.person for the new columns
COMMENT ON COLUMN cjams.person.intercountryadoption IS 'Yes/No values for Inter country adoption';
COMMENT ON COLUMN cjams.person.priorlegalguardianship IS 'Yes/No/Abandoned values for Prior Legal Guardianship';
COMMENT ON COLUMN cjams.person.preplacementguardianshipdate IS 'Previous placement date if Prior Legal Guardiansip is Yes';