-- CIDM-8011 - AFCARS 2.0 code modifications for MD AFCARS 23A Data errors reported by ACF

-- Modifiy afcars_fc_child_removals to add column to identify the removal of Bio client
ALTER TABLE cjams.afcars_fc_child_removals ADD COLUMN IF NOT EXISTS bio_cjamspid varchar NULL;
COMMENT ON COLUMN cjams.afcars_fc_child_removals.bio_cjamspid IS 'CJAMS Bio Client Number'; 

COMMENT ON COLUMN cjams.afcars_fc_child_removals.caseid IS 'CJAMS Service Case Number';

ALTER TABLE cjams.afcars_fc_placements ADD COLUMN IF NOT EXISTS placementcpahomeid uuid NULL;
COMMENT ON COLUMN cjams.afcars_fc_placements.placementcpahomeid IS 'Foreign key - PK of CPA Home placement table'; 

ALTER TABLE cjams.afcarsadoptiondetail ADD COLUMN IF NOT EXISTS A4_child_date_of_birth varchar NULL;
COMMENT ON COLUMN cjams.afcarsadoptiondetail.A4_child_date_of_birth IS 'Client Date of Birth';;

