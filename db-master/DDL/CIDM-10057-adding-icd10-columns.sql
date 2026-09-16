alter table personmedicalcondition add column if not exists medicalcondition_icd10_desc varchar NULL;   
COMMENT ON COLUMN personmedicalcondition.medicalcondition_icd10_desc IS 'ICD 10 Description of the medical condition.';

alter table personmedicalcondition add column if not exists medicalcondition_icd10_key_id varchar NULL;   
COMMENT ON COLUMN personmedicalcondition.medicalcondition_icd10_key_id IS 'ICD 10 unique idenitifier (a code) for the medical condition';